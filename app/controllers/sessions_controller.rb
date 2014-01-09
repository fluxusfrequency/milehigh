class SessionsController < ApplicationController

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    user.find_avatar
    session[:user_id] = user.id
    redirect_to home_path
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end
