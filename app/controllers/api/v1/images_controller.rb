class Api::V1::ImagesController < ApiApplicationController
   before_filter :autenticate_user

	def create
        # byebug
        return render_message({responseCode: PARTIAL_CONTENT,responseMessage: PARTIAL_CONTENT_MESSAGE}) unless params[:images_params][:image].present?
        params[:image] = Image.image_data(params[:images_params][:image].to_s.gsub("\\r\\n",""))
	    image = @user.images.new(image_params)
	    if image.save
				return render_message({responseCode: SUCCESS,responseMessage: "Image uploaded successfully!"})
		else
				return render_message({responseCode: ERROR,responseMessage: image.errors.full_messages.first.capitalize.to_s.gsub('_',' ') + "."})
		end

    end

    private
	def images_params
       params.permit(:image)
	end


end




