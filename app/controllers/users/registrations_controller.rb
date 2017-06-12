class Users::RegistrationsController < Devise::RegistrationsController

  # override devise registration action
  def create
    byebug
    super
   # super do |resource|
      GlobalMailer.welcome_email(resource).deliver if resource.save
   #  end
  end

  #PUT /resource
  def update
    super
  end

end

end
