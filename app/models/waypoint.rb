class Waypoint < ApplicationRecord
    # has_many :meanders

  # Returns points in our circular search band
  def self.waypoints_in_radius_of(current_waypoint, min_search_radius, max_search_radius)
    #point, distance
    # p "*"*50
    # p "inside waypoints_in_rad"
    # p "variables, current/min/max"
    # p current_waypoint
    # p min_search_radius
    # p max_search_radius
    rando = 'SPHEROID["WGS 84", 6378137, 298.257223563]'
    waypoint_text = current_waypoint.location.as_text
    p waypoint_text
    sql_query =
      "ST_Distance_Spheroid(location, ST_GeomFromText('#{waypoint_text}'), '#{rando}') < #{max_search_radius} AND ST_Distance_Spheroid(location, ST_GeomFromText('#{waypoint_text}'), '#{rando}') > #{min_search_radius}"
    Waypoint.where(sql_query)
  end

  # Returns points closer to the endpoint
  def self.find_waypoints_closer_to_end(current_waypoint, destination)
    current_text = current_waypoint.location.as_text
    destination_text = destination.location.as_text
    sql_query = "ST_DistanceSphere(location, ST_GeomFromText('#{destination_text}')) < ST_DistanceSphere(ST_GeomFromText('#{current_text}'), ST_GeomFromText('#{destination_text}'))"
    Waypoint.where(sql_query)
  end

  # compares the two arrays and returns array of potential next waypoints in radius and closer to destination.
  # Good on standalone test
  def find_potential_next_waypoints(destination, min_search_radius, max_search_radius)
    # p "*"* 50
    # p "inside find-potential"
    # p self
    waypoints_in_band = Waypoint.waypoints_in_radius_of(self, min_search_radius, max_search_radius)
    waypoints_closer = Waypoint.find_waypoints_closer_to_end(self, destination)
    waypoint_options = (waypoints_in_band & waypoints_closer)
  end


end
  # PATRICK"S PERSONAL MISSION>>>>
  # "ST_Distance(ST_GeomFromText('#{current_text}'), ST_GeomFromText('#{destination_text}'))"
  # .where() must be type boolean
  # .find() looks for id
  # .query() undefined method query
  # .select() returns array
  # def find_distance_to_end(destination)
  #   current_text = self.location.as_text
  #   p "cur location"
  #   p current_text
  #   destination_text = destination.location.as_text
  #   p "des location"
  #   p destination_text
  #   sql_query = "ST_Distance_Sphere(ST_GeomFromText('#{current_text}'), ST_GeomFromText('#{destination_text}'))"
  #   distance = Waypoint.where(sql_query)
  #   p "Distance"
  #   p distance
  # end

  # set default modifier to 0.1 in variable?
  # def search_radius(full_distance, modifier)
  #   #set standard modifier to be 0.1
  #   radius = full_distance * modifier
  # end

  # def initial_distance(destination)
  #   # latitude_midpoint = (self.location.x + destination.location.x)/2.0
  #   # # p latitude_midpoint
  #   # m_per_deg_lat = 111132.954 - 559.822 * Math.cos( 2 * latitude_midpoint ) + 1.175 * Math.cos( 4 * latitude_midpoint)
  #   # m_per_deg_lon = 111132.954 * Math.cos( latitude_midpoint )
  #   current_text = location.as_text
  #   destination_text = destination.location.as_text

  #   sql_query = "ST_Distance(ST_GeomFromText('#{current_text}'), ST_GeomFromText('#{destination_text}'))"
  #   Waypoint.select(sql_query)
  # end

  # def distance_conversion(lat1, lat2)
  #   latMid = (Lat1+Lat2 )/2.0;
  #   m_per_deg_lat = 111132.954 - 559.822 * cos( 2 * latMid ) + 1.175 * cos( 4 * latMid);
  #   m_per_deg_lon = 111132.954 * cos( latMid );
  # end

