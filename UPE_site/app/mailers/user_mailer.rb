class UserMailer < ActionMailer::Base
	default :from => "admin@UPE_Portal"
	
  def registration_confirmation(user)
  	@user = user
  	@url = "localhost"
  	mail(:to => user.email, :subject => "Thanks for registering!")
  end
end
