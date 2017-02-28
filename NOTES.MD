

# Notes on methods available:
  # https://github.com/rgeo/activerecord-postgis-adapter
  # .lonlat = ## sets the value to a given point

# Potential considerations for Future Release Updates:
  # https://github.com/alexreisner/geocoder
  # Look at integrating Google geocoder for more functions 
  
  # Sample of methods avail with geocoder gem:

  # Venue.near('Omaha, NE, US', 20)    
    # venues within 20 miles of Omaha
  # Venue.near([40.71, -100.23], 20)    
    # venues within 20 miles of a point
  # Venue.near([40.71, -100.23], 20, :units => :km)
    # venues within 20 kilometres of a point
  # Venue.geocoded                     
    # venues with coordinates
  # Venue.not_geocoded                 
    # venues without coordinates

  # if obj.geocoded?
    # obj.nearbys(30)                      
      # other objects within 30 miles
    # obj.distance_from([40.714,-100.234]) 
      # distance from arbitrary point to object
    # obj.bearing_to("Paris, France")      
      # direction from object to arbitrary point
  # end

  # obj.distance - number of miles from the search point to this object
  # obj.bearing - direction from the search point to this object