class QuantilePeriod
  include Mongoid::Document
  
  field :name, type: String
  
  attr_accessible :name
end
