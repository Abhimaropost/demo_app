class ImagesController < ApplicationController


	def index
        @images= current_user.images.page(params[:page]).per(8)
	end

	# def new

	# end

	def create
   # build a photo and pass it into a block to set other attributes
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



	def show

	end

	def edit

	end

	def update

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
