class MakeReports
  include Sidekiq::Worker
  
  def perform(report_id)
    report = Report.find(report_id)
    
    report.start
    
    script = '/home/jiang/projects/quantilemapping/v3/draw_extreme_day_count.py'
    data_dir = "/home/jiang/projects/quantilemapping/results/run_auto/"
    # SCRIPT      LIST OF TILES                        LON     LAT     TITLE            LOW TEMP   HIGH TEMP
    # #{script} "obs_YYYY_YYYY.tif adj_YYYY_YYYY.tif"  213.75  53.75   "Gulf of Alaska" 2.0        15.0
    cmd = [script, data_dir, "\"#{report.column1_file} #{report.column2_file}\"", "'#{report.location.lon}'", "'#{report.location.lat}'", "\"#{report.location.name}\"", "'#{report.low_temp_threshold}'", "'#{report.high_temp_threshold}'"]
    
    puts "Running: #{cmd.join(' ')}"
    puts `#{cmd.join(' ')}` 
    
    report_path = Rails.root.join('public', 'reports', report.id.to_s).to_s
    FileUtils.mkdir_p(report_path)
    `cp #{data_dir}/extreme_day_count_#{File.basename(report.column1_file, '.tif')}_#{File.basename(report.column2_file, '.tif')}*.png #{report_path}` 
    
    report.finish
  rescue => e
    report.try(:fail)
    raise e
  end
end