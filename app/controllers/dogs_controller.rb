class DogsController < ApplicationController
  respond_to :json

  def index
    unless params[:pet_id]
      render_400 and return
    end
    tries ||= 10
    begin
      pet = petfinder.pet(params[:pet_id])
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
end
