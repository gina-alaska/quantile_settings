class Report
  include Mongoid::Document
  
  field :high_temp_threshold, type: Integer
  field :low_temp_threshold, type: Integer
  field :column1, type: String
  field :column2, type: String
  field :type, type: String, default: 'extreme_day_count'
  field :status, type: String, default: 'New'
  field :historical_year, type: Integer
  field :predicted_year, type: Integer
  
  attr_accessible :high_temp_threshold, :low_temp_threshold, :column1, :column2, :location_id, :type, :historical_year, :predicted_year
  
  belongs_to :quantile_setting
  belongs_to :location

  accepts_nested_attributes_for :location
  
  TYPES = [['Extreme day count', 'extreme_day_count'], ['One year quantile', 'one_year_quantile']]
  
  after_create :queue
  
  REPORT_BASEPATH = Rails.root.join('public', 'reports').to_s
  
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
  
  def files
    path = File.join(REPORT_BASEPATH, self.id.to_s)
    Dir.glob(File.join(path, '*.png')).collect do |f|
      f.gsub(Rails.public_path, '')
    end
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
    when :unadjusted
      "prd_#{self.quantile_setting.predicted_start}_#{self.quantile_setting.predicted_end}.tif"
    when :adjusted
      "adj_#{self.quantile_setting.algorithm}_#{self.quantile_setting.predicted_start}_#{self.quantile_setting.predicted_end}.tif"
    end
  end
end
