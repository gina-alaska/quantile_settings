class Report < ActiveRecord::Base
  attr_accessible :high_temp_threshold, :low_temp_threshold, :column1, :column2, :quantile_settings_id, :location_id
  
  belongs_to :quantile_setting
  belongs_to :location
  
  after_create :queue
  
  def queue
    self.status = 'Queued'
    self.save!
    
    MakeReports.perform_async(self.id)
  end
  
  def fail
    self.status = 'Error'
    self.save!
  end
  
  def start
    self.status = 'Started'
    self.save!
  end
  
  def finish
    self.status = 'Finished'
    self.save!
  end
  
  def column1_file
    case self.column1.to_sym
    when :historical
      "his_#{self.quantile_setting.historical_start}_#{self.quantile_setting.historical_end}.tif"
    when :observed
      "obs_#{self.quantile_setting.historical_start}_#{self.quantile_setting.historical_end}.tif"
    end
  end
  
  def column2_file
    case self.column2.to_sym
    when :predicted
      "prd_#{self.quantile_setting.predicted_start}_#{self.quantile_setting.predicted_end}.tif"
    when :adjusted
      "adj_#{self.quantile_setting.predicted_start}_#{self.quantile_setting.predicted_end}.tif"
    end
  end
end
