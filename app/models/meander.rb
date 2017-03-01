class Meander < ApplicationRecord
  # has_many :waypoints

  def meander(current_waypoint, destination)
    # 150 m min
    min_search_radius = 150
    # 800 m max
    max_search_radius = 800
    distance_to_end = self.initial_distance(current_waypoint, destination)
    # p "Dist" * 80
    # p distance_to_end
    route_path(current_waypoint, destination, distance_to_end, min_search_radius, max_search_radius).slice(0..-2)
  end

  def route_path(current_waypoint, destination, distance_to_end, min_search_radius, max_search_radius, points_of_interest = [])
    if distance_to_end > 160000

    end
    # p "*"*60
    # p "calls function"
    # p "here are our variables"
    # p current_waypoint
    # p destination
    # p distance_to_end
    # p min_search_radius
    # p max_search_radius
    # p points_of_interest
    next_waypoint = choose_next_waypoint(current_waypoint, destination, min_search_radius, max_search_radius)
    # p "*"*50
    # p "chooses next waypoint"
    # p next_waypoint
    if points_of_interest.length > 20
      # p "*"*100
      # p points_of_interest
      return points_of_interest
    end
    if next_waypoint == nil
      # p "*"*50
      # p 'waypoint was nil'
      if max_search_radius < distance_to_end
        min_search_radius += 650
        max_search_radius += 650
        next_waypoint = route_path(current_waypoint, destination, distance_to_end, min_search_radius, max_search_radius, points_of_interest)
      else
        p "*"*100
        p points_of_interest
        return points_of_interest
        #stop adding points and route to destination
      end
    else
      # p "*"*50
      # p 'found a waypoint'
      points_of_interest << next_waypoint
      # p '*'*100
      # p points_of_interest
      min_search_radius = 150
      max_search_radius = 800
      route_path(next_waypoint, destination, distance_to_end, min_search_radius, max_search_radius, points_of_interest)
    end
    # add to aggregate array of coords/waypoints => return it
  end

  # returning one waypoint from the array of next potential options
  # good on standalone test
  def choose_next_waypoint(current_waypoint, destination, min_search_radius, max_search_radius)
    # p "*"*50
    # p "inside choose next"
    # p "variables"
    # p current_waypoint
    # p destination
    # p min_search_radius
    # p max_search_radius
    current_waypoint.find_potential_next_waypoints(destination, min_search_radius, max_search_radius).sample
  end

  # Calculates distance between start and end point at beginning of Meander / Walk
  # Good on standalone test
  def initial_distance(start_point, end_point)
    long1 = start_point.location.x
    long2 = end_point.location.x
    lat1 = start_point.location.y
    lat2 = end_point.location.y
    dtor = Math::PI/180
    r = 6378.14*1000

    rlat1 = lat1 * dtor
    rlong1 = long1 * dtor
    rlat2 = lat2 * dtor
    rlong2 = long2 * dtor

    dlon = rlong1 - rlong2
    dlat = rlat1 - rlat2

    a = (Math::sin(dlat/2)**2) + Math::cos(rlat1) * Math::cos(rlat2) * (Math::sin(dlon/2)**2)
    c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))
    p d = r * c
  end

  def self.assemble_meander_coordinates(array_waypoints)
    # p "*"*100
    # p "assemble coordinates"
    # p array_waypoints
    array_waypoints.map { |waypoint| waypoint.location.coordinates.reverse! }
    # p "reversed"
    # p new_array
  end
end
