class Users::RegistrationsController < Devise::RegistrationsController

  # override devise registration action
  def create
    # byebug
    super
  end

  #PUT /resource
  def update
    super
  end

protected

def build_resource(hash=nil)
  hash[:password] = hash[:password_confirmation] = User.assign_password(hash[:email]) if hash[:email]
  super(hash)
end


end
