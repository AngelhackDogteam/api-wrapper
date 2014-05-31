class SheltersController < ApplicationController
  respond_to :json

  def index
    tries ||= 10
    begin
      shelter = petfinder.shelter(params[:shelter_id])
      @shelter = XmlToShelterConverter.convert(shelter)
      render json: @shelter and return
    rescue Excon::Errors::SocketError
      retry unless (tries -= 1).zero?
    else
      render_400 and return
    end 
  end
end
