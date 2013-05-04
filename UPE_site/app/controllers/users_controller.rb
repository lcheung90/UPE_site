class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if params[:cancel_btn]
      redirect_to root_url and return
    end
    if @user.save
      UserMailer.registration_confirmation(@user).deliver
      reset_session
      session[:user_id] = @user.id
      redirect_to user_url(@user.username), :notice => "Thanks for signing up!  A confirmation email has been sent."
    else
      render "new"
    end
  end

  def show
    @user = User.find_by_username(params[:id])
    @questions = Question.find_all_by_user_id(@user.id)
    #@answers = Question.find_all_by_user_id(@user.id)
  end
end