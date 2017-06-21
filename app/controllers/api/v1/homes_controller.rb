class Api::V1::HomesController < ApiApplicationController
 # before_filter :autenticate_user
    # http://0.0.0.0:4000/api/v1/homes/contact_mail.json?
	def contact_mail ## will pass parameter in hashes
		byebug
		begin
			if !contact_params.present?  || ( contact_params.present? && (  !contact_params[:name].present?  || !contact_params[:email].present? ||  !contact_params[:phone].present? ||  !contact_params[:description].present?))
				return render_message({responseCode: PARTIAL_CONTENT,responseMessage: PARTIAL_CONTENT_MESSAGE})
			end
		    contact_mail_info={name: contact_params[:name] , phone_number: contact_params[:phone], email: contact_params[:email] , description: contact_params[:description] }

			Notify.contact_us_mail( contact_mail_info ).deliver
 			return render_message({responseCode: SUCCESS,responseMessage: "Thanks for submitting your request. Someone will get back to you in 48hrs."})
		rescue Exception => e
 			return render_message({responseCode: ERROR,responseMessage: "Something went wrong! Please try again later!"})
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
