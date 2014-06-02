class DogsController < ApplicationController
  respond_to :json
  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers

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
