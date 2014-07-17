class SessionsController < ApplicationController
  skip_before_filter :authorize, :verify_authenticity_token

  def create
    user = SessionsController.helpers.find_or_create_user(auth_params)
    session[:user_id] = user.id

    redirect_to "/topic/index", :notice => "Signed In!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed Out!"""
  end

  private
  def auth_params
    request.env["omniauth.auth"]
  end
end
