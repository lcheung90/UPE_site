class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :load_current_user

  
  def load_current_user
  	@current_user = User.find_by_id(session[:user_id]) if session[:user_id]
  end
  def search
  	@tags = Tag.search(params[:search])
  	@questions = Question.search(params[:search])
  	@users = User.search(params[:search])
  	render 'shared/search'
  end
end
