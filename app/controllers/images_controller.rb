class ImagesController < ApplicationController

	def index
        @images= current_user.images.page(params[:page]).per(8)
	end
	def create
        # byebugs
	    @photo = current_user.images.new(image_params)
		respond_to do |format|
			if @photo.save!
			    flash[:success] = "Image uploaded successfully!"
			    format.html {redirect_to images_path }
		        format.js { redirect_to images_path}
			else
		        format.html { render 'images/index'}
			end
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
	    status = Image.exists?(["lower(title) = ?", params[:image][:title].downcase])
	    render :json => !status
	end

	private
      def image_params
         params.require(:image).permit(:title, :photo)
      end

end
