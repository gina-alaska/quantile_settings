class Location
  include Mongoid::Document
  
  field :lat, type: BigDecimal
  field :lon, type: BigDecimal
  field :name, type: String
  
  attr_accessible :lat, :lon, :name
end
