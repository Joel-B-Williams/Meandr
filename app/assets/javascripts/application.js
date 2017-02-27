// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).ready(function(){
  initMap();
  $("#add-waypoint-button").on("click", function(){
    navigator.geolocation.getCurrentPosition(findLocation);
  });
  $("#find-route-button").on("click", function(){
    var startPointLat = $('#current-user-lat').html()
    var startPointLng = $('#current-user-long').html()
    var endPointLat = $('#desired-end-lat').html()
    var endPointLng = $('#desired-end-long').html()
    if (endPointLat == "end latitude") {
      alert('Search for an endpoint')
    } else {
      // console.log(startPointLat);
      // console.log(startPointLng);
      // console.log(endPointLat);
      // console.log(endPointLng);
      getWalkingRoute(startPointLat, startPointLng, endPointLat, endPointLng);
    }
  });
});

function initMap(){
  var defaultPosition = {lat: 11.8251, lng: 42.5903};
  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 14,
    center: defaultPosition
  });
  // Create the search box and link it to the UI element.
  var input = document.getElementById('search-input');
  var searchBox = new google.maps.places.SearchBox(input);
  map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
  // Bias the SearchBox results towards current map's viewport.
  map.addListener('bounds_changed', function(){
    searchBox.setBounds(map.getBounds());
  });
  var markers = [];

  // Listen for the event fired when the user selects a prediction and retrieve more details for that place.
  searchBox.addListener('places_changed', function() {
    var places = searchBox.getPlaces();
    if (places.length == 0) {
      return;
    }
    // Clear out the old markers.
    markers.forEach(function(marker) {
      marker.setMap(null);
    });
    markers = [];

    // For each place, get the icon, name and location.
    var bounds = new google.maps.LatLngBounds();
    places.forEach(function(place) {
      if (!place.geometry) {
        console.log("Returned place contains no geometry");
        return;
      }
      console.log(place);
      console.log(place.geometry.location);
      document.getElementById('end-location').innerHTML = place.geometry.location;
      document.getElementById('desired-end-lat').innerHTML = place.geometry.location.lat();
      document.getElementById('desired-end-long').innerHTML = place.geometry.location.lng();
      // Customized icons
      var icon = {
        url: place.icon,
        size: new google.maps.Size(71, 71),
        origin: new google.maps.Point(0, 0),
        anchor: new google.maps.Point(17, 34),
        scaledSize: new google.maps.Size(25, 25)
      };
      // Create a marker for each place.
      markers.push(new google.maps.Marker({
        map: map,
        // icon: icon,
        title: place.name,
        position: place.geometry.location
      }));

      if (place.geometry.viewport) {
        // Only geocodes have viewport.
        bounds.union(place.geometry.viewport);
      } else {
        bounds.extend(place.geometry.location);
      }
    });
    map.fitBounds(bounds);
  });
  // set variable for user start location before get current loc call
  var startPosition;
  // Setting current location on map to user location
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position){
      var crd = position.coords;
      var myLatLng = {lat: crd.latitude, lng: crd.longitude};
      // Log starting user location on page in hidden div for use later
      document.getElementById('current-user-lat').innerHTML = crd.latitude;
      document.getElementById('current-user-long').innerHTML = crd.longitude;
      var marker = new google.maps.Marker({
        position: myLatLng,
        map: map,
        title: 'Meanderer'
      });
      map.setCenter(myLatLng);
    });
    } else {
      alert('GeoLocation is not supported by your browser');
    }
};

function findLocation(pos) {
  var crd = pos.coords;
  var myLatLng = {lat: crd.latitude, lng: crd.longitude};
  saveLocation(myLatLng);
};

function saveLocation(myLatLng) {

  $.ajax({
    url: '/waypoints',
    method: 'post',
    data: {location: myLatLng},
    })
    .done(function(response) {
      console.log("success");
      console.log(response);
      $("#thanks").html("<b>Thank you for sharing this location with us!</b>")
    })
    .fail(function() {
      console.log("error");
    })
};

function getWalkingRoute(startLat, startLng, endLat, endLng){
  var meandr_info = {
      startLatitude: startLat,
      startLongitude: startLng,
      endLatitude: endLat,
      endLongitude: endLng
    }
  $.ajax({
    url: '/meandrs',
    type: 'post',
    // dataType: 'default: Intelligent Guess (Other values: xml, json, script, or html)',
    data: { meandr: meandr_info },
    })
    .done(function(response) {
      // console.log(response);
      // console.log(response.start);
      console.log("success");
      var startPoint = convertWaypoint(response.start);
      // console.log(startPoint);
      var endPoint = convertWaypoint(response.end);
      // console.log(endPoint);
      var convertedWaypoints = convertWaypoints(response.waypoints);
      getDirectionsMap(startPoint, endPoint, convertedWaypoints);

    })
    .fail(function() {
      console.log("error");
    })
}

function convertWaypoints(waypointArray){
  var googleWaypoints = [];
  for (var i=0; i<waypointArray.length; i++){
    googleWaypoints.push({location: convertWaypoint(waypointArray[i]), stopover: false})
  }
  // console.log(googleWaypoints);
  return googleWaypoints;
}

function convertWaypoint(waypoint){
  // console.log(waypoint[0]);
  return new google.maps.LatLng(waypoint[0], waypoint[1]);
}

function getDirectionsMap(startPoint, endPoint, convertedWaypoints){
  var directionsService = new google.maps.DirectionsService;
  var directionsDisplay = new google.maps.DirectionsRenderer;
  // var bounds = new google.maps.LatLngBounds();
  var map = new google.maps.Map(document.getElementById('map'));
  directionsDisplay.setMap(map);

  // console.log(startPoint)
  // console.log(startPoint.geometry)
  // console.log(startPoint.geometry.location)
  // debugger
  // bounds.extend(startPoint)
  // bounds.extend(endPoint)

  directionsService.route({
    origin: startPoint,
    destination: endPoint,
    waypoints: convertedWaypoints,
    travelMode: 'WALKING'
  }, function(response, status){
    if (status === 'OK') {
      debugger
      directionsDisplay.setDirections(response);
      var routes = response.routes[0];
      console.log(response);
      console.log(routes);
    } else {
      window.alert('Directions request failed due to ' + status);
    }
  })
}




  // // Declare all the variables we'll need to use.
  // var infowindow = null;
  // var userCoords;

  //Start the GeoLocation
  // if (navigator.geolocation) {
  //   function error(err){
  //     console.warn('ERROR(' + err.code + '): ' + err.message);
  //   }
  //   // on success we assign coordinates to usercords variable
  //   function success(pos) {
  //     userCoords = pos.coords;
  //   }

  //   // Get the user's current position
  //   navigator.geolocation.getCurrentPosition(success, error);
  //   //console.log(pos.latitude + " " + pos.longitude);
  //   } else {
  //     alert('GeoLocation is not supported by your browser');
  //   }
   // End Geo Location (Note: this last close bracket may not be necessary )


  // // Map Options
  // var mapOptions = {
  //   zoom: 14,
  //   center: userCoords
  // }

  // // Add info window when user hovers over point on map
  // infoWindow = new google.maps.InfoWindow({
  //   content: "holding..."
  // });

  // // Fire up google maps and place inside the map-canvas div
  // map = new google.maps.Map(document.getElementById('map'), mapOptions);


// TUTORIALS:
// https://www.youtube.com/watch?v=Hv76o8PEKwk
// https://www.youtube.com/watch?v=W0juXNFLd6w

//Add listener
// google.maps.event.addListener(marker, "click", function (event) {
//     var latitude = event.latLng.lat();
//     var longitude = event.latLng.lng();
//     console.log( latitude + ', ' + longitude );

//     radius = new google.maps.Circle({map: map,
//         radius: 100,
//         center: event.latLng,
//         fillColor: '#777',
//         fillOpacity: 0.1,
//         strokeColor: '#AA0000',
//         strokeOpacity: 0.8,
//         strokeWeight: 2,
//         draggable: true,    // Dragable
//         editable: true      // Resizable
//     });

//     // Center of map
//     map.panTo(new google.maps.LatLng(latitude,longitude));
// }); //end addListener
