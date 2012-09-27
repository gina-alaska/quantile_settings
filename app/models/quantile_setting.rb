class QuantileSetting < ActiveRecord::Base
  belongs_to :period, class_name: 'QuantilePeriod'
  has_many :reports
  
  attr_accessible :algorithm, :historical_start, :historical_end, :period_id, :predicted_end, :predicted_start
  
  validates :historical_start, inclusion: { in: 1957..2002, message: "%{value} must be between 1957 and 2002" }
  validates :historical_end, inclusion: { in: 1957..2002, message: "%{value} must be between 1957 and 2002" }
  validates :predicted_start, inclusion: { in: 2006..2100, message: "%{value} must be between 2006 and 2100" }
  validates :predicted_end, inclusion: { in: 2006..2100, message: "%{value} must be between 2006 and 2100" }
  
  def as_args
    #TODO: figure out what the args should be to run the quantile command
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
end
