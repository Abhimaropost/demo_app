class ApiApplicationController < ActionController::Base
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' ||  c.request.format == :json }
  before_action   :ensure_json_request

  # validate json only request
  def ensure_json_request
    return render_message({status:ERR_STATUS,responseMessage: NOT_ACCEPTABLE_MESSAGE, responseCode: NOT_ACCEPTABLE }) unless request.format == :json
  end

  # authenticate user and return if not exist
  def autenticate_user
    # byebug
    auth_token = request.headers[:HTTP_AUTH_TOKEN] #auth_token in header
    return render_message ({status:ERR_STATUS, responseMessage: "Sorry! You are not an authenticated user.",responseCode: ERROR}) unless auth_token
    @user = User.find_by(auth_token: auth_token)
    unless @user
      return render_message({status:ERR_STATUS,responseMessage: UNAUTHORIZED_MESSAGE,responseCode: UNAUTHORIZED})
    end
  end

  def render_message hash
    render :json => {
      :status=>  hash[:status],
      :message => hash[:responseMessage],
      :code => hash[:responseCode],
      :data => hash[:data]
    }.reject {|key,value| value.blank? }
  end

  def request_params_validator hash , type
    status = true
    case type
    when"contact"
      if  hash.blank?
          return render_message({status:ERR_STATUS,responseMessage: "Empty body", responseCode: ERROR}) , status
      elsif ( contact_params.present? && (  !contact_params[:name].present?  || !contact_params[:email].present? ||  !contact_params[:phone].present? ||  !contact_params[:description].present?))
          return render_message({status:ERR_STATUS,responseMessage: PARTIAL_CONTENT_MESSAGE, responseCode: PARTIAL_CONTENT}) , status
     end
    when "user"
      if hash.blank?
         return render_message({status:ERR_STATUS,responseMessage: "Empty body",responseCode: ERROR}) , status
      elsif (user_params.present?   && (!user_params[:email].present? || !user_params[:password].present? || !user_params[:password_confirmation].present?))
         return render_message({status:ERR_STATUS,responseMessage: PARTIAL_CONTENT_MESSAGE,responseCode: PARTIAL_CONTENT}) , status
      end
    when "image"
      if images_params.blank?
        return render_message({status:ERR_STATUS,responseMessage: "Empty body", responseCode: PARTIAL_CONTENT}) , status
      elsif (!images_params[:title].present? || !images_params[:photo].present?)
        return render_message({status:ERR_STATUS,responseMessage: PARTIAL_CONTENT_MESSAGE, responseCode: PARTIAL_CONTENT}) , status
      end
    end
  end



end



# manage un-matched route for api => done
# need to handle bad request  => done
# no route match => done
# empty body => done
# authenticate user => done


# execption handling
# delete object if not presents
# mail background


# K4IGGtKLbF1QF3APCxJLLQ