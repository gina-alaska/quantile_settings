class QuantileSetting
  include Mongoid::Document
  
  ALGORITHMS = %w{ SIMPLE RQUANT QUANT }
  
  field :historical_start, type: Integer
  field :historical_end, type: Integer
  field :predicted_start, type: Integer
  field :predicted_end, type: Integer
  field :algorithm, type: String, default: 'SIMPLE'
  field :status, type: String, default: 'New'
  
  has_many :reports
  
  attr_accessible :historical_start, :historical_end, :predicted_end, :predicted_start, :algorithm
  
  validates :historical_start, inclusion: { in: 1957..2002, message: "%{value} must be between 1957 and 2002" }
  validates :historical_end, inclusion: { in: 1957..2002, message: "%{value} must be between 1957 and 2002" }
  validates :predicted_start, inclusion: { in: 2006..2100, message: "%{value} must be between 2006 and 2100" }
  validates :predicted_end, inclusion: { in: 2006..2100, message: "%{value} must be between 2006 and 2100" }
  
  def as_args
    #TODO: figure out what the args should be to run the quantile command
  end
  
  def path
    return nil if self.new_record?
    
    Rails.root.join("public/data/#{self.id}").to_s
  end
  
  def queue
    self.status = 'Queued'
    self.save!
    
    DoMapping.perform_async(self.id)
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
    [
      "his_#{self.quantile_setting.historical_start}_#{self.quantile_setting.historical_end}.tif",
      "obs_#{self.quantile_setting.historical_start}_#{self.quantile_setting.historical_end}.tif",
      "prd_#{self.quantile_setting.predicted_start}_#{self.quantile_setting.predicted_end}.tif",
      "adj_#{self.quantile_setting.algorithm}_#{self.quantile_setting.predicted_start}_#{self.quantile_setting.predicted_end}.tif"
    ]
  end
end
