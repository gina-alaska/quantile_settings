# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

QuantilePeriod.create(name: 'year')
QuantilePeriod.create(name: 'season')
QuantilePeriod.create(name: 'month')
QuantilePeriod.create(name: 'day')


# Locations
=begin
1       213.75  53.75   1989    1979    Gulf of Alaska
2       188.75  61.25   1989    1979    Bering Sea
3       203.75  66.25   1989    1979    Interior
4       206.25  68.75   1989    1979    Far North
5       208.75  73.75   1989    1979    Arctic Ocean
=end

Location.create(lon: 213.75,  lat: 53.75, name:"Gulf of Alaska")
Location.create(lon: 188.75,  lat: 61.25, name:"Bering Sea")
Location.create(lon: 203.75,  lat: 66.25, name:"Interior")
Location.create(lon: 206.25,  lat: 68.75, name:"Far North")
Location.create(lon: 208.75,  lat: 73.75, name:"Arctic Ocean")