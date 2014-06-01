class BreedsController < ApplicationController
  respond_to :json

  def index
    unless params[:location]
      render_400 and return
    end
    tries ||= 10

    begin
      options = params.select {|k, v| %w(size breed sex age offset count).include? k}
      pets = petfinder.find_pets('dog', params[:location], options)
      @pets = []
      pets.each do |pet|
        next unless pet.sex == options["sex"]
        
        @pets << XmlToPetConverter.convert(pet)
      end
      render json: @pets and return
    rescue Excon::Errors::SocketError
      unless (tries -= 1).zero?
        retry 
      else
        render_400 and return
      end
    end
  end

  def on_load
    unless params[:ip]
      render_400 and return
    end
    ip = Rails.env.development? ? "38.108.97.34" : params[:ip]

    geocoded_location = IpGeocoder.geocode(ip)
    location = geocoded_location.zip.present? ? 
      geocoded_location.zip : "#{geocoded_location.city},#{geocoded_location.state}"

    tries ||= 10
    begin
      pets = petfinder.find_pets('dog', location)
      @pets = []
      pets.each do |pet|
        @pets << XmlToPetConverter.convert(pet)
      end
      render json: @pets and return
    rescue Excon::Errors::SocketError
      unless (tries -= 1).zero?
        retry 
      else
        render_400 and return
      end
    end
  end

  def show
    options = params.keep_if {|p| [:size, :breed, :sex, :age, :offset, :count].include? p}
    @pets = petfinder.find_pets('dog', params[:location], options)
    # binding.pry
  end


end
