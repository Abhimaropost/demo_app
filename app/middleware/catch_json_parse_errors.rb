class CatchJsonParseErrors
  def initialize(app)
    @app = app
  end

  def call(env)
    begin
      @app.call(env)
    rescue ActionDispatch::ParamsParser::ParseError => error
      unless env['CONTENT_TYPE'].match(/application\/json/).blank?
        error_output = "There was a problem in the JSON you submitted: #{error}"
        return [
          500, { "Content-Type" => "application/json" },
          [ { status: "Failure", message: "There was a problem in the JSON you submitted" , code: 500}.to_json ]
        ]
      else
        raise error
      end
    end
  end
end


