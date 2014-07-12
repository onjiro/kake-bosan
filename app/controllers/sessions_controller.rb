class SessionsController < ApplicationController
  skip_before_filter :authorize

  def create
    auth = auth_params

    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)

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
