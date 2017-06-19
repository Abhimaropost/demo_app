class BackgroundWorker
  include Sidekiq::Worker
  sidekiq_options  :retry => 3


  def perform(params,user,type)
    # Do something
  end
end



