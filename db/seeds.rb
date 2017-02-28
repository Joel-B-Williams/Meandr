# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Waypoint.create(location: 'POINT(-87.653217 41.876448)') #0 4dbc

Waypoint.create(location: 'POINT(-87.647490 41.879617)') #1 5dugans

Waypoint.create(location: 'POINT(-87.657240 41.876645)') #2 6wise owl

Waypoint.create(location: 'POINT(-87.656140 41.874853)') #3 7UIC Pavillion

Waypoint.create(location: 'POINT(-87.647180 41.875540)') #4 8UIC blue line

Waypoint.create(location: 'POINT(-87.648000 41.871955)') #5 9UIC student center

Waypoint.create(location: 'POINT(-87.647670 41.884654)') #6 10Au Cheval


# What is this measure?  Distance used?
# This is 1 mile.

#centered on DBC give or take
#41.876452, -87.653214
10000.times do
  x = rand( 41.85471286956522..41.89819113043478)
  y = rand(-87.68068652747253..-87.62574147252748)
  Waypoint.create(location: "POINT(#{y} #{x})")
end

# # #1 mile north
# #41.890891, -87.653244
# 1000.times do
#   x = rand(41.8825576635..41.899224336500005)
#   y = rand(-87.6615773365..-87.6449106635)
#   Waypoint.create(location: "POINT(#{y} #{x})")
# end

# # #2 miles north -> goose island
# # #41.905397, -87.653659
# 1000.times do
#   x = rand(41.8970636635..41.9137303365)
#   y = rand(-87.6619923365..-87.6453256635)
#   Waypoint.create(location: "POINT(#{y} #{x}")
# end

# # #3 miles north -> lincoln park, near ba-ba-reeba/armitage stop
# #41.919876, -87.654084
# 1000.times do
#   x = rand(41.9115426635..41.928209336500004)
#   y = rand(-87.6624173365..-87.6457506635)
#   Waypoint.create(location: "POINT(#{y} #{x}")
# end

# #second city
# #41.911504, -87.635253
# 1000.times do
#   x = rand(41.9031706635..41.9198373365)
#   y = rand(-87.64358633650001.. -87.6269196635)
#   Waypoint.create(location: "POINT(#{y} #{x}")
# end

# Test Walk from DBC to 648 W Randolph Street.
# 4,215.71 ft


# 10000.times do
#   x = rand(41.86037366..41.88504033)
#   y = rand(-87.661557333..-87.64489066)
#   Waypoint.create(location: "POINT(#{x} #{y})")
# end

# 100000.times do
#   x = rand(41.86037366..41.88504033)
#   y = rand(-87.661557333..-87.64489066)
#   Waypoint.create(location: "POINT(#{x} #{y})")
# end

# Waypoint.create(location: 'POINT(41.876451 -87.653213)')

# Density of points
# 10 pts
# 50 pts
# 100 pts
# 1000 pts
# 10000 pts
# 100000 pts
# 1000000 pts

# Distances
# 1/10th mile
# 1/2 mile
# 1 mile
# 10 miles
# 50 miles
# 100 miles

# When does it break?

# When does it slow down?

# What is the degredation?
# How do we measure the speed?
