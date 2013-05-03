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
      reset_session
      session[:user_id] = @user_id
      redirect_to user_url(@user.username), :notice => "Signed up"
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