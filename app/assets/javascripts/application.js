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

$(document).ready(function() {
  initMap();
  $("#directions-button").on('click', function() {
    initialize();
    })
})
function initMap() {
  function success(pos) {
    var crd = pos.coords;
    var myLatLng = {lat: crd.latitude, lng: crd.longitude};
    var map = new google.maps.Map(document.getElementById('map'), {
      zoom: 4,
      center: myLatLng
    });
  var marker = new google.maps.Marker({
    position: myLatLng,
    map: map,
    title: 'Hello World!'

  });
  saveLocation(myLatLng);
};
  $("#location-button").on("click", function(){
    navigator.geolocation.getCurrentPosition(success);
  })
}

function saveLocation(myLatLng) {
  $.ajax({
    url: '/waypoints',
    method: 'post',
    data: {location: myLatLng},
    })
    .done(function(response) {
      console.log("success");
      console.log(response);
    })
    .fail(function() {
      console.log("error");
    })
}

var directionDisplay;
var directionsService = new google.maps.DirectionsService();
var map;

    function initialize() {
        directionsDisplay = new google.maps.DirectionsRenderer();
        var chicago = new google.maps.LatLng(41.850033, -87.6500523);
        var myOptions = {
            zoom: 6,
            mapTypeId: google.maps.MapTypeId.ROADMAP,
            center: chicago
        };
        map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
        directionsDisplay.setMap(map);
        calcRoute();
    }
function calcRoute() {
    var first = new google.maps.LatLng(41.8763849,-87.6576869);
    var second = new google.maps.LatLng(41.878536,-87.6565791);
    var origin = new google.maps.LatLng(41.8749315, -87.6591852);
    var destination = new google.maps.LatLng(41.8790977, -87.6531115);

    var request = {
        origin: origin,
        destination: destination,
        waypoints: [{location: first, stopover: false},
            {location: second, stopover: false}],
        optimizeWaypoints: true,
        travelMode: google.maps.DirectionsTravelMode.WALKING
    };
    directionsService.route(request, function (response, status) {
        if (status == google.maps.DirectionsStatus.OK) {
            directionsDisplay.setDirections(response);
            var route = response.routes[0];
            var summaryPanel = document.getElementById("directions_panel");
            summaryPanel.innerHTML = "";
            // For each route, display summary information.
            for (var i = 0; i < route.legs.length; i++) {
                var routeSegment = i + 1;
                summaryPanel.innerHTML += "<b>Route Segment: " + routeSegment + "</b><br />";
                summaryPanel.innerHTML += route.legs[i].start_address + " to ";
                summaryPanel.innerHTML += route.legs[i].end_address + "<br />";
                summaryPanel.innerHTML += route.legs[i].distance.text + "<br /><br />";
            }
        } else {
            alert("directions response " + status);
        }
    });
}

