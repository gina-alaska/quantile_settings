class DoMapping
  include Sidekiq::Worker
  
  def perform(settings_id)
    settings = QuantileSetting.find(settings_id)
    
    settings.start
    # do the stuff to run the command here
    script = '/home/jiang/projects/quantilemapping/v3/quantile_mapping_auto.py'
    cmd = [script, settings.historial_start, settings.historical_end, settings.predicted_start, settings.predicted_end, settings.period.name, settings.algorithm]
    #script.py 1910 2001 2030 2060 Yearly 0
    
    puts "Running: #{cmd.join(' ')}"
    puts `#{cmd.join(' ')}`  
    
    settings.finish
  rescue => e
    settings.fail
    raise e
  end
end
