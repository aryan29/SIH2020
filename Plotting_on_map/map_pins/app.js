// In this example, we center the map, and add a marker, using a LatLng object
// literal instead of a google.maps.LatLng object. LatLng object literals are
// a convenient way to add a LatLng coordinate and, in most cases, can be used
// in place of a google.maps.LatLng object.

var map, marker_center;
function initMap() {
  

  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: -34.397, lng: 150.644},
    zoom: 7
  });

  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var pos = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };
      marker_center = new google.maps.Marker({
        position: pos,
        title:"Hello World!"
      });
    
    // To add the marker to the map, call setMap();
      marker_center.setMap(map);
   
      map.setCenter(pos);
    }, function() {
      handleLocationError(true, marker, map.getCenter());
    });
  } else {
    // Browser doesn't support Geolocation
    handleLocationError(false, marker, map.getCenter());
  }
  
  
  function handleLocationError(browserHasGeolocation, infoWindow, pos) {
  infoWindow.setPosition(pos);
  infoWindow.setContent(browserHasGeolocation ?
                        'Error: The Geolocation service failed.' :
                        'Error: Your browser doesn\'t support geolocation.');
  infoWindow.open(map);
  }

  var data = [{"index": 2, "latitude": 23.0, "longitude": 85.0}, {"index": 3, "latitude": 24.0, "longitude": 84.0}, {"index": 8, "latitude": 23.5, "longitude": 85.54}, {"index": 3.5, "latitude": 24.0, "longitude": 85.56}, {"index": 7, "latitude": 25.14, "longitude": 82.54}, {"index": 10, "latitude": 25.0, "longitude": 83.5}];

  for (var i = 0; i < data.length; i++) {
  
    var col =  'http://maps.google.com/mapfiles/ms/icons/red-dot.png';
    if(data[i].index>=0 & data[i].index<=3.3){
      col =  'http://maps.google.com/mapfiles/ms/icons/green-dot.png'
    }
    else if(data[i].index>3.3 & data[i].index<=7.3){
      col = 'http://maps.google.com/mapfiles/ms/icons/yellow-dot.png'
    }

    var marker = new google.maps.Marker({
        position: { lat: data[i].latitude, lng: data[i].longitude},
        map: map,
        icon: col,
       
    });


    var infowindow = new google.maps.InfoWindow({
        content: "<p>Marker Location:" + marker.getPosition() + "</p>"
    });


    google.maps.event.addListener(marker, "click", function() {
      infowindow.open(map, marker);
    });
  }
  

}
