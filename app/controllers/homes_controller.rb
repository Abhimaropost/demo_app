class HomesController < ApplicationController

    def dashboard;end

	def about_us;end

	def contact_us;end

	def guest_user;end

    def app_user;end

    def server_error; end

    def contact_mail ## will pass parameter in hashes
    	return redirect_to :back  unless params[:c_name].present? && params[:c_email].present? && params[:c_phone].present? && params[:c_description].present?
    	name= params[:c_name]
		email= params[:c_email]
		phone_number= params[:c_phone]
		description= params[:c_description]
		Notify.contact_us_mail( name,email,phone_number,description ).deliver
		flash[:notice]= "Thanks for submitting your request. Someone will get back to you in 48hrs."

	    redirect_to dashboard_homes_path

	end


end
