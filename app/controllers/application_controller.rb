class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def petfinder
    @petfinder || Petfinder::Client.new
  end

  def render_400
    render :nothing => true, :status => 400
  end
end
