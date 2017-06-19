class Notify < ApplicationMailer
	default from: 'notifications@example.com'

  def welcome_email mail_hash
    @random_password = mail_hash[:password]
    @user = mail_hash[:object]
    @email = @user.email
    @login_url  = 'http://127.0.0.1:4000/users/sign_in'
    mail(to: @email, subject: 'Welcome to My Awesome Site')
  end

  def contact_us_mail  info
     @name = info[:name]
     @email = info[:email]
     @phone_number = info[:phone_number]
     @description = info[:description]
     mail(to: @email, subject: 'Thanks for cantacting us!')
  end
end
