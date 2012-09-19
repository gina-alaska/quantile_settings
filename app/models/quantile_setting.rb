class QuantileSetting < ActiveRecord::Base
  belongs_to :period, class_name: 'QuantilePeriod'
  
  attr_accessible :algorithm, :historial_start, :historical_end, :period_id, :predicted_end, :predicted_start
  
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
