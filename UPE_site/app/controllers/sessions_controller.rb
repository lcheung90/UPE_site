class SessionsController < ApplicationController
	def new
	end

	def create
		@user = User.find_by_username(params[:session][:username].downcase)
		if @user && @user.authenticate(params[:session][:password])
			reset_session
			session[:user_id] = @user.id
			flash[:notice] = "Successfully Logged in"
			redirect_to user_url(params[:session][:username])
		else
			flash.now[:notice] = "Please provide valid credentials"
			render :new
		end
	end

	def destroy
		reset_session
		flash[:notice] = "Successfully Logged out"
		redirect_to root_url
	end
end