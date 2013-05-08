class SessionsController < ApplicationController
  def new
      @user = User.new
  end
  
  def create
  @user = User.find_by_username(params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      reset_session
      session[:user_id] = @user.id
      redirect_to @user, :notice => "Logged in!"
    else
      flash.now[:notice] = "Invalid username or password"
      render "public_pages/home"
    end
  end

  def destroy
    reset_session
      flash[:notice] = "Successfully Logged out"
      redirect_to root_url
  end
end