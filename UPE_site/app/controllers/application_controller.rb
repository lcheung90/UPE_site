class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :load_current_user

  
  def load_current_user
  	@current_user = User.find(session[:user_id]) if session[:user_id]
  end
end
