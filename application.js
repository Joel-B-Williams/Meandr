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
};
  $("#button").on("click", function(){
    navigator.geolocation.getCurrentPosition(success);
  })
}
