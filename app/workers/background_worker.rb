class BackgroundWorker
  include Sidekiq::Worker
  sidekiq_options  :retry => false

  def perform(object_arr)
    Notify.welcome_email(object_arr).deliver_now if object_arr.class == Hash and object_arr["type"] === "acknowledge"
    Notify.contact_us_mail(object_arr).deliver_now if object_arr.class == Hash  and object_arr["type"] === "contact"
    Image.create_object object_arr if  object_arr.class == Array and object_arr.first["type"] === "image"
  end

end

