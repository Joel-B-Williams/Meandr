# require 'rails_helper'

# describe Meander do

#   let(:meander) { Meander.create! }
#   let(:dbc) { Waypoint.create!(location: 'POINT(41.876451 -87.653213)') }
#   let(:dugans) { Waypoint.create!(location: 'POINT(41.879618 -87.647487)') }
#   let(:wise_owl) { Waypoint.create!(location: 'POINT(41.876647 -87.657238)') }
#   let(:uic) { Waypoint.create!(location: 'POINT(41.874853 -87.656140)') }
#   let(:blue_line) { Waypoint.create!(location: 'POINT(41.875540 -87.647181)') }
#   let(:student_center) { Waypoint.create!(location: 'POINT(41.871955 -87.647998)') }
#   let(:au_cheval) { Waypoint.create!(location: 'POINT(41.884659 -87.647666)') }

#   describe "#choose_next_waypoint" do
#     it "returns a waypoint object if there is one" do
#       meander
#       dbc
#       dugans
#       wise_owl
#       uic
#       blue_line
#       student_center
#       au_cheval

#       expect(meander.choose_next_waypoint(dbc, au_cheval, 0.7)).to be_an_instance_of(Waypoint)
#     end

#     it "returns nil if there are no waypoints" do
#       meander
#       dbc
#       dugans
#       wise_owl
#       uic
#       blue_line
#       student_center
#       au_cheval

#       expect(meander.choose_next_waypoint(uic, blue_line, 0.3)).to eq nil
#     end
#   end

#   describe "#route_path" do
#     it "returns an array with points of interest" do
#        meander
#       dbc
#       dugans
#       wise_owl
#       uic
#       blue_line
#       student_center
#       au_cheval

#       expect(meander.route_path(dbc, au_cheval, 0.7)[0]).to be_an_instance_of(Waypoint)
#     end
#   end

#   describe "#meander" do
#     it "returns an array with a possible route" do
#       meander
#       dbc
#       dugans
#       wise_owl
#       uic
#       blue_line
#       student_center
#       au_cheval

#       expect(meander.meander(dbc, au_cheval)[0]).to be_an_instance_of(Waypoint)
#     end
#   end
# end
