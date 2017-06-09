class Users::RegistrationsController < Devise::RegistrationsController

  # override devise registration action
  def create
    byebug
    super
   # super do |resource|
   #    UserMailer.send_welcome_email(resource)
   #  end
  end

  #PUT /resource
  def update
    super
  end

end
