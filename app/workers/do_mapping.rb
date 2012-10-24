class DoMapping
  include Sidekiq::Worker
  
  def perform(settings_id)
    settings = QuantileSetting.find(settings_id)
    
    settings.start
    # do the stuff to run the command here
    script = '/home/jiang/projects/quantilemapping/v3/quantile_mapping_auto.py'
    cmd = [script, settings.historical_start, settings.historical_end, settings.predicted_start, settings.predicted_end, settings.algorithm]
    #script.py 1910 2001 2030 2060 
    
    puts "Running: #{cmd.join(' ')}"
    puts `#{cmd.join(' ')}`  
    
    FileUtils.mkdir_p(settings.path)
    
    data_dir = "/home/jiang/projects/quantilemapping/results/run_auto/"
    settings.files.each do |file|
      FileUtils.cp(File.join(data_dir, file), settings.path)
    end
    
    settings.finish
  rescue => e
    settings.fail
    raise e
  end
end
