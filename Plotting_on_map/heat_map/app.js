// In this example, we center the map, and add a marker, using a LatLng object
// literal instead of a google.maps.LatLng object. LatLng object literals are
// a convenient way to add a LatLng coordinate and, in most cases, can be used
// in place of a google.maps.LatLng object.


var map,marker;
function initMap() {

 /* Data points defined as a mixture of WeightedLocation and LatLng objects */
 var heatMapData = [];
 var data = [{"index": 2, "latitude": 80.0, "longitude": 50.0}, {"index": 3.5, "latitude": 27.0, "longitude": 90.0}, {"index": 8, "latitude": 31.14, "longitude": 75.54}, {"index": 1, "latitude": 31.0, "longitude": 75.5}, {"index": 7, "latitude": 31.14, "longitude": 72.54}, {"index": 4, "latitude": 31.0, "longitude": 70.5}];
 for (var i = 0; i < data.length; i++) 
 {
   heatMapData[i] = ({location: new google.maps.LatLng(data[i].latitude, data[i].longitude), weight: data[i].index});
   
 }

 map = new google.maps.Map(document.getElementById('map'), {
  center: {lat: -34.397, lng: 150.644},
  zoom: 5
});
infoWindow = new google.maps.InfoWindow;

// Try HTML5 geolocation.
if (navigator.geolocation) {
  navigator.geolocation.getCurrentPosition(function(position) {
    var pos = {
      lat: position.coords.latitude,
      lng: position.coords.longitude
    };
    marker = new google.maps.Marker({
      position: pos,
      title:"Hello World!"
    });
  
  // To add the marker to the map, call setMap();
    marker.setMap(map);
 
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



var heatmap = new google.maps.visualization.HeatmapLayer({
  data: heatMapData
});
heatmap.setMap(map);
}
