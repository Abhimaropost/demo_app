class Api::V1::UsersController < ApiApplicationController

  #http://0.0.0.0:4000/api/v1/users.json?
  def create
    message,status = request_params_validator user_params, "user"
    return message if status === true
    user = User.new(user_params)
    if user.save
      return render_message({status:SUCCESS_STATUS,responseMessage: "User has been successfully created!",
        responseCode: SUCCESS,
        data: user.as_json(:only => [:id,:email])})
    else
      return render_message({status:ERR_STATUS,responseMessage: user.errors.full_messages.first.capitalize.to_s.gsub('_',' ') + "." ,responseCode: ERROR})
    end
  end

  private
  def user_params
    params.permit(:email,:password,:password_confirmation)
  end

end

