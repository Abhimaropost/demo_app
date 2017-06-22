class BackgroundWorker
  include Sidekiq::Worker
  sidekiq_options  :retry => false
  def perform(object_arr)
  	byebug
    Notify.welcome_email(object_arr).deliver_now if object_arr["type"] === "acknowledge"
    Notify.contact_us_mail(object_arr).deliver_now if object_arr["type"] === "contact"
    Image.create_object object_arr if object_arr["type"].blank?
  end

end


# : vs ""