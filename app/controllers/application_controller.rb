class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  skip_before_filter :verify_authenticity_token

  def petfinder
    @petfinder || Petfinder::Client.new
  end

  def render_400
    render json: {
      error: "Bad request",
      status: 400
    }, status: 400
  end
end
