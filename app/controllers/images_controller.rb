class ImagesController < ApplicationController
   before_action :authenticate_user!

	def index
      @images= current_user.images.page(params[:page]).per(8)
	end

    def create
	  path =  images_path
	  unless (params[:image][:photo]).content_type== "text/csv"
	    @photo = current_user.images.new(image_params)
	    if @photo.save
	      flash[:success] = "Image uploaded successfully!"
	    else
	      flash[:notice]= "Something went wrong! Please try again later!"
	      path =  dashboard_homes_path
	    end
	  else
	    message = Image.import(params[:image][:photo], current_user)
	    flash[:success] = message
	  end
	  redirect_to path
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

	def image_count
	  sleep 3
      total_images = current_user.images.size || 0
	  render :json => total_images
    end


	def validate_uniqueness
	  status = current_user.images.exists?(["lower(title) = ?", params[:title].downcase])
	  render :json => status
	end

	private
      def image_params
        params.require(:image).permit(:title, :photo)
      end

end
