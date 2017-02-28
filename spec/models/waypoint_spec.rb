# require 'rails_helper'

# describe Waypoint do

#   let(:dbc) { Waypoint.create!(location: 'POINT(41.876451 -87.653213)') }
#   let(:dugans) { Waypoint.create!(location: 'POINT(41.879618 -87.647487)') }
#   let(:wise_owl) { Waypoint.create!(location: 'POINT(41.876647 -87.657238)') }
#   let(:uic) { Waypoint.create!(location: 'POINT(41.874853 -87.656140)') }
#   let(:blue_line) { Waypoint.create!(location: 'POINT(41.875540 -87.647181)') }
#   let(:student_center) { Waypoint.create!(location: 'POINT(41.871955 -87.647998)') }
#   let(:au_cheval) { Waypoint.create!(location: 'POINT(41.884659 -87.647666)') }

#   it "has coordinates" do
#     expect(dbc.location.coordinates).to eq [41.876451, -87.653213]
#   end

#   describe "#find_distance_to" do
#     it "finds the distance to another waypoint" do
#       expect(dbc.find_distance_to(au_cheval)).to eq 0.009906587353870087
#     end
#   end

#   describe "#closer_to_end" do
#     it "knows if it's closer to the end point than the current waypoint" do
#       expect(dugans.closer_to_end(dbc, au_cheval)).to be true
#       expect(dbc.closer_to_end(dugans, au_cheval)).to be false
#     end
#   end

#   describe "#search_radius" do
#     it "calculates a search radius around itself" do
#       expect(dbc.search_radius(dbc.find_distance_to(au_cheval), 0.1)).to eq 0.0009906587353870088
#     end
#   end

#   describe "#waypoints_in_radius_of" do
#     it "expects waypoint count to be 7" do
#       expect(Waypoint.count).to eq 0
#     end

#     it "finds all waypoints within the search radius" do
#       dbc
#       dugans
#       wise_owl
#       uic
#       blue_line
#       student_center
#       au_cheval

#       expect(Waypoint.waypoints_in_radius_of(dbc, dbc.search_radius(dbc.find_distance_to(au_cheval), 0.9))).to include(dugans)
#     end
#   end
# end



