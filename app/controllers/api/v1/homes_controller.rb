class Api::V1::HomesController < ApiApplicationController
 before_filter :autenticate_user,only: [:contact_mail]

    # http://0.0.0.0:4000/api/v1/homes/contact_mail.json?
	def contact_mail
		# byebug
	  begin
	    message,status = request_params_validator contact_params, "contact"
		return message if status === true
	    contact_mail_info={name: contact_params[:name] , phone_number: contact_params[:phone],
	    	email: contact_params[:email] , description: contact_params[:description],type: "contact" }
        BackgroundWorker.perform_async contact_mail_info

		return render_message({status:SUCCESS_STATUS,responseMessage: "Thanks for submitting your request. Someone will get back to you in 48hrs.",
		 responseCode: SUCCESS})
		rescue Exception => e
		   return render_message({status:ERR_STATUS,responseMessage: "Something went wrong! Please try again later!",
			 responseCode: ERROR})
	  end
	end

    def server_error
	  respond_to do |format|
	     format.json { render :json => {status:SUCCESS_STATUS, :response_message => NO_ROUTE_MESSAGE, :response_code => NO_ROUTE} }
	    format.html {  }
	  end
    end

    private
    def contact_params
      params.permit(:name,:email,:phone,:description)
   end

end

# {
# "email": "developabhishek@gmail.com",
# "name":  "Abhishek",
# "phone":  "9873346003",
# "description": "TESTING"
# }
