class SessionsController < ApplicationController
  skip_before_action :store_location

  def callback
    user = User.from_omniauth(request.env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_back_for root_path
  end

  def destroy
    session[:user_id] = nil
    session[:return_to] = nil
    redirect_back_for root_path
  end

  def failure
    session[:return_to] = nil
    redirect_back_for root_path
  end

  def redirect_back_for(default_path)
    redirect_to(session[:return_to] || default_path)
    session[:return_to] = nil
  end
end
