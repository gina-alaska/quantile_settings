class DoMapping
  include Sidekiq::Worker
  
  def perform(settings_id)
    settings = QuantileSetting.find(settings_id)
    
    settings.start
    # do the stuff to run the command here
    
    settings.finish
  rescue => e
    settings.fail
    raise e
  end
end