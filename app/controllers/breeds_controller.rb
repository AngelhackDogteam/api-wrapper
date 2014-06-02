class BreedsController < ApplicationController
  respond_to :json
  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers

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

  def random_pet
    unless params[:location]
      render_400 and return
    end
    tries ||= 10

    begin
      options = params.select {|k, v| %w(size breed sex age offset count location).include? k}
      options.merge!({animal: 'dog'})
      pet = petfinder.random_pet(options)
      @pet = XmlToPetConverter.convert(pet)
      render json: @pet and return
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
    fixed_ip = params[:ip].gsub('-', '.')
    ip = Rails.env.development? ? "38.108.97.34" : fixed_ip
    logger.info "ip: #{ip}"
    geocoded_location = Geokit::Geocoders::IpGeocoder.geocode(ip)
    
    location = if geocoded_location.zip.present? 
      geocoded_location.zip
    elsif geocoded_location.city != "Unknown City" 
      "#{geocoded_location.city},#{geocoded_location.state}"
    else 
      "10009"
    end

    tries ||= 10
    begin
      # pets = petfinder.find_pets('dog', location)
      conn = Faraday.new(:url => 'http://api.petfinder.com') do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
      response = conn.get '/pet.find', {animal: 'dog', location: location, count: 100, 
        format: 'json', key: 'ba13722a78b94d3d56f9c4e8d26ce68f'}
      data = JSON.load response.body
      # binding.pry
      pets = PetProxy.multiple(data['petfinder'])
      @pets = []
      pets.each do |pet|
        @pets << XmlToPetConverter.convert(pet)
      end

      render json: {data: @pets} and return
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
