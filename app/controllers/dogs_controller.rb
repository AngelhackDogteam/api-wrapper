class DogsController < ApplicationController
  respond_to :json

  def index
    tries ||= 10
    begin
      pet = petfinder.pet(params[:pet_id])
      @pet = XmlToPetConverter.convert(pet)
      render json: @pet and return
    rescue Excon::Errors::SocketError
      retry unless (tries -= 1).zero?
    else
      render_400 and return
    end 
  end
end
