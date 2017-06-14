class Notify < ApplicationMailer
	# default from: 'notifications@example.com'

  def welcome_email object
    @user = object
    @email = object.email
    @login_url  = 'http://127.0.0.1:4000/users/sign_in'
    mail(to: @email, subject: 'Welcome to My Awesome Site')
  end

  def contact_us_mail  name,email,phone_number,description
     @name = name
     @email = email
     @phone_number = phone_number
     @description = description
     mail(to: @email, subject: 'Thanks for cantacting us!')

  end
end
