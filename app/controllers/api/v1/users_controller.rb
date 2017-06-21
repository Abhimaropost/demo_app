class Api::V1::UsersController < ApiApplicationController
 # before_filter :autenticate_user
 def create #http://0.0.0.0:4000/api/v1/users.json?
  byebug
   if user_params.present?   && (!user_params[:email].present? || !user_params[:password].present? || !user_params[:password_confirmation].present?)
    return render_message({responseCode: PARTIAL_CONTENT,responseMessage: PARTIAL_CONTENT_MESSAGE})
   end
    user = User.new(user_params)
    if user.save
      return render_message({responseCode: SUCCESS,responseMessage: "User has been successfully created!",
      	       object: user})
    else
      return render_message({responseCode: ERROR,responseMessage: user.errors.full_messages.first.capitalize.to_s.gsub('_',' ') + "." })
    end

 end

  private
  def user_params
    params.permit(:email,:password,:password_confirmation)
  end

end


# body
# {

# "email": "qq@gmail.com",
# "password": "12345678",
# "password_confirmation": "12345678"


# }