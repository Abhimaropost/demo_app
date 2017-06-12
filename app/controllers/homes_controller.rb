class HomesController < ApplicationController

        def dashboard

    end

	def about_us;end

	def contact_us;end

	def guest_user;end

    def app_user;end

    def contact_mail
    	name= params[:c_name]
		email= params[:c_email]
		phone_number= params[:c_phone]
		desc= params[:c_description]
		# UserMailer.contact_us_mail(name,email,phone_number,desc).deliver
		flash[:notice]= "Thanks for submitting your request. Someone will get back to you in 48hrs."

	    redirect_to dashboard_homes_path, notice: 'Thanks for submitting your request. Someone will get back to you in 48hrs.' unless current_user

	end


end
