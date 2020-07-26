// In this example, we center the map, and add a marker, using a LatLng object
// literal instead of a google.maps.LatLng object. LatLng object literals are
// a convenient way to add a LatLng coordinate and, in most cases, can be used
// in place of a google.maps.LatLng object.


var map;
function initMap() {
  /*var mapOptions = {
    zoom: 8,
    center: { lat: 37, lng: 122 }
  };
  map = new google.maps.Map(document.getElementById("map"), mapOptions);*/

 /* Data points defined as a mixture of WeightedLocation and LatLng objects */
 var heatMapData = [];
 var data = [{"index": 2, "latitude": 80.0, "longitude": 50.0}, {"index": 35, "latitude": 27.0, "longitude": 90.0}, {"index": 80, "latitude": 31.14, "longitude": 75.54}, {"index": 35, "latitude": 31.0, "longitude": 75.5}, {"index": 7, "latitude": 31.14, "longitude": 72.54}, {"index": 40, "latitude": 31.0, "longitude": 70.5}];
 for (var i = 0; i < data.length; i++) 
 {
   heatMapData[i] = ({location: new google.maps.LatLng(data[i].latitude, data[i].longitude), weight: data[i].index});
   
 }

var sanFrancisco = new google.maps.LatLng(30, 75);

map = new google.maps.Map(document.getElementById('map'), {
  center: sanFrancisco,
  zoom: 5,
  //mapTypeId: 'satellite'
});

var heatmap = new google.maps.visualization.HeatmapLayer({
  data: heatMapData
});
heatmap.setMap(map);
}
