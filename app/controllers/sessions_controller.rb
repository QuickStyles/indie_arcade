class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email params[:email]
    byebug
    session[:user_id] = user.id if user && user.authenticate(params[:password])
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
