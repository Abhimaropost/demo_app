class ApiApplicationController < ActionController::Base
  # protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' ||  c.request.format == :json }
  before_action   :ensure_json_request#:parse_request ,

	def render_message hash
   	render :json => {
      :response_code => hash[:responseCode],
      :response_message => hash[:responseMessage],
      :object => hash[:object]
    }
  end

  # validate request body formate for handle unprocessable_entity
  # def parse_request
  #   p"111111111"
  #   begin
  #     @user_input = JSON.parse(request.body.read)
  #   rescue JSON::ParserError => e
  #     return render_message({responseCode: UNPROCESSABLE_ENTITY,responseMessage: UNPROCESSABLE_ENTITY_MESSAGE})
  #     # render json: {error: "Invalid JSON format"}, status: :unprocessable_entity
  #   end
  # end

  # validate json only request
  def ensure_json_request
    return render_message({responseCode: NOT_ACCEPTABLE,responseMessage: NOT_ACCEPTABLE_MESSAGE }) unless request.format == :json
  end

  # authenticate user and return if not exist
  def autenticate_user
    # byebug
    auth_token = request.headers[:HTTP_AUTHORIZATION]
    return render_message ({responseCode: ERROR, responseMessage: "Sorry! You are not an authenticated user."}) unless auth_token
    @user = User.find_by(auth_token: auth_token)
    unless user
      render_message({responseCode: UNAUTHORIZED,responseMessage: UNAUTHORIZED_MESSAGE})
    end
  end





end



#response in json only.  https://stackoverflow.com/questions/21978580/rails-4-respond-only-to-json-and-not-html
# manage un-matched route for api => done

# delete object if not presents
#need to handle bad request
#no route match
# execption handling
# empty body