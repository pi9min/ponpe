class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :store_location
  helper_method :current_user

  include MetaTaggable

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def store_location
    session[:return_to] = request.url
  end
end
