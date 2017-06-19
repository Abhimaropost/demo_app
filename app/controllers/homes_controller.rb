class HomesController < ApplicationController
    before_action :authenticate_user!, :except => [:dashboard,:guest_user]

    def dashboard;end

	def about_us;end

	def contact_us;end

	def guest_user;end

    def app_user;end

    def server_error; end

    def contact_mail ## will pass parameter in hashes
		begin
	       return redirect_to :back  unless params[:c_name].present? && params[:c_email].present? && params[:c_phone].present? && params[:c_description].present?
		   contact_mail_info={name: params[:c_name] , phone_number: params[:c_phone], email: params[:c_email] , description: params[:c_description] }
			Notify.contact_us_mail( contact_mail_info ).deliver
			flash[:notice]= "Thanks for submitting your request. Someone will get back to you in 48hrs."
		    redirect_to dashboard_homes_path
		rescue Exception => e
			flash[:notice]= "Something went wrong! Please try again later!"
		    redirect_to dashboard_homes_path
		end
	end

end


