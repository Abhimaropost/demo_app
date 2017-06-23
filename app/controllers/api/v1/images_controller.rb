class Api::V1::ImagesController < ApiApplicationController
   before_filter :autenticate_user
   before_filter :find_image,only: [:show]

    #http://0.0.0.0:4000/api/v1/images.json?
	def create
      message,status = request_params_validator images_params, "image"
		return message if status === true
	    photo = Image.image_data(images_params[:photo].to_s.gsub("\\r\\n",""))
	    image = @user.images.new(title:images_params[:title], photo:  photo)
	    if image.save
		  return render_message({status:SUCCESS_STATUS,responseMessage: "Image uploaded successfully!",
				responseCode: SUCCESS, data: image.as_json(:only => [:id,:title]).merge!(image_url: image.photo.url) })
		else
		  return render_message({status:ERR_STATUS,responseMessage: message_error(image.errors) , responseCode: ERROR})
		end
    end

    # /api/v1/images/:id(.:format)
    def show
	  return render_message({status:SUCCESS_STATUS,responseMessage: "Image found successfully",responseCode: SUCCESS,
	    data: @image.as_json(only:[:id,:title]).merge(image_url: @image.photo.url)
	    	})
    end

    private
	def images_params
      params.permit(:title,:photo)
	end

    # before_filter for authenticate user
	def find_image
	  id = params[:id]
	  return render_message ({status:ERR_STATUS, responseMessage: "Invalid request", responseCode: ERROR}) unless id
	  @image = Image.find_by(id: id)
	  unless @image
	    return render_message({status:ERR_STATUS,responseMessage: "No record found", responseCode: ERROR})
	  end
	end

    # method for handle image formate error
	def message_error errors
      errors.full_messages.find{|object| /en.errors.messages.extension_whitelist_error/ =~ object }.nil? ?
        errors.full_messages.first.capitalize.to_s.gsub('_',' ') + "." :
        'Only jpeg,jpg and png allowed!'
	end

end





