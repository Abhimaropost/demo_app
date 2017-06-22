class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

    # Exception handeling
    # if Rails.env.production?
  if Rails.env.development?
    unless Rails.application.config.consider_all_requests_local
      rescue_from Exception, with: :render_500
    end
  end

  def render_500(exception)
    logger.info exception.backtrace.join("\n")
    respond_to do |format|
      format.html { redirect_to server_error_homes_path }
      format.json{ render_message 500,"Please try again."}
    end
  end


end


