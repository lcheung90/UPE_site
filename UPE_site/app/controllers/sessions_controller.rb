class SessionsController < ApplicationController
  def new
  end
  
  def create
  @user = User.find_by_email(params[:email])
  if @user && @user.authenticate(params[:password])
    reset_session
    session[:user_id] = @user.id
    redirect_to user_url(@user.username), :notice => "Logged in!"
  else
    flash.now.alert = "Invalid email or password"
    render "new"
  end
end

def destroy
  reset_session
    flash[:notice] = "Successfully Logged out"
    redirect_to root_url
end