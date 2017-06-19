class ImagesController < ApplicationController
   before_action :authenticate_user!

	def index
        @images= current_user.images.page(params[:page]).per(8)
	end

	def create
        # byebug
	   unless (params[:image][:photo]).content_type== "text/csv"
		    @photo = current_user.images.new(image_params)
		    if @photo.save
				flash[:success] = "Image uploaded successfully!"
				redirect_to images_path
			else
			    flash[:notice]= "Something went wrong! Please try again later!"
		        redirect_to dashboard_homes_path
			end
		else
	        success_count, error_count = Image.import(params[:image][:photo], current_user)
	        byebug
			flash[:success] = "Image uploaded with #{success_count} success  and  #{error_count} errors "
			redirect_to images_path
	   end

    end


    def update_title
		status = Image.all_except(params[:id]).exists?(["lower(title) = ?", params[:title].downcase])
		result = false
		unless  status
		  result = true
		  image = Image.find_by(id: params[:id])
		  image.update_attributes(title: params[:title])
		end
		render json: result
	end


	def destroy

	end

	def validate_uniqueness
	    status = Image.exists?(["lower(title) = ?", params[:title].downcase])
	    render :json => status
	end

	private
      def image_params
         params.require(:image).permit(:title, :photo)
      end

end
