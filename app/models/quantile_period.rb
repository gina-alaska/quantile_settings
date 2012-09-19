class QuantilePeriod < ActiveRecord::Base
  has_many :settings, class_name: 'QuantileSetting'
  
  attr_accessible :name
end
