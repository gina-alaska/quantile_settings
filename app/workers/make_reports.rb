class MakeReports
  include Sidekiq::Worker
  
  def perform(report_id)
    report = Report.find(report_id)
    
    report.start
	
	if report.type == 'extreme_day_count'
		extreme_report(report)
	else
		one_year_report(report)
	end
    
    report.finish
  rescue => e
    report.try(:fail)
    raise e
  end
  
  
  def extreme_report(report)
    script = '/home/jiang/projects/quantilemapping/v3/draw_extreme_day_count.py'
    #data_dir = "/home/jiang/projects/quantilemapping/results/run_auto/"
    data_dir = report.quantile_setting.path
    
    # SCRIPT      LIST OF TILES                        LON     LAT     TITLE            LOW TEMP   HIGH TEMP
    # #{script} "obs_YYYY_YYYY.tif adj_YYYY_YYYY.tif"  213.75  53.75   "Gulf of Alaska" 2.0        15.0
    cmd = [script, '--', data_dir, "\"#{report.column1_file} #{report.column2_file}\"", report.location.lon, report.location.lat, "\"#{report.location.name}\"", report.low_temp_threshold, report.high_temp_threshold]
    cmd = cmd.join(' ')
    
    puts "Running: #{cmd}"
    puts `#{cmd}` 
    
    FileUtils.mkdir_p(report.path)
    
    reports = File.join(data_dir, "extreme_day_count_#{File.basename(report.column1_file, '.tif')}_#{File.basename(report.column2_file, '.tif')}_#{report.location.name.split(' ').first}_*.png")
    `mv #{reports} #{report.path}` 
  end
  
  def one_year_report(report)
    #draw_his_obs_odt_prd_adj.py $data_dir "his_1971_2000.tif obs_1971_2000.tif odt_1971_2000.tif prd_2071_2100.tif adj_2071_2100.tif" 213.75 53.75 "Gulf of Alaska" "1976" "2076"
    
    script = '/home/jiang/projects/quantilemapping/v3/draw_his_obs_odt_prd_adj.py'
    data_dir = "/home/jiang/projects/quantilemapping/results/run_auto/"
    
    data_files = "his_#{report.quantile_setting.historical_start}_#{report.quantile_setting.historical_end}.tif"
    data_files << " obs_#{report.quantile_setting.historical_start}_#{report.quantile_setting.historical_end}.tif"
    data_files << " odt_#{report.quantile_setting.historical_start}_#{report.quantile_setting.historical_end}.tif"
    data_files << " prd_#{report.quantile_setting.predicted_start}_#{report.quantile_setting.predicted_end}.tif"
    data_files << " adj_#{report.quantile_setting.predicted_start}_#{report.quantile_setting.predicted_end}.tif"
    cmd = %{
      #{script} -- #{data_dir} "#{data_files}" #{report.location.lon} #{report.location.lat} "#{report.location.name}" #{report.historical_year} #{report.predicted_year}
    }
    
    puts "Running: #{cmd}"
    puts `#{cmd}` 
    
    report_path = Rails.root.join('public', 'reports', report.id.to_s).to_s
    FileUtils.mkdir_p(report_path)
    
    reports = File.join(data_dir, "his_obs_odt_prd_adj_#{report.historical_year}_#{report.predicted_year}_#{report.location.name.split(' ').first}.png")
    `cp #{reports} #{report_path}` 
    
  end
end
