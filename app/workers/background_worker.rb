class BackgroundWorker
  include Sidekiq::Worker
  sidekiq_options  :retry => false
  def perform(object_arr)
    Image.create_object object_arr
  end

end



