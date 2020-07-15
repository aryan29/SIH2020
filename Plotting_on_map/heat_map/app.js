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
var heatMapData = [
  {location: new google.maps.LatLng(37.782, -122.447), weight: 0.5},
  new google.maps.LatLng(37.782, -122.445),
  {location: new google.maps.LatLng(37.782, -122.443), weight: 2},
  {location: new google.maps.LatLng(37.782, -122.441), weight: 3},
  {location: new google.maps.LatLng(37.782, -122.439), weight: 2},
  new google.maps.LatLng(37.782, -122.437),
  {location: new google.maps.LatLng(37.782, -122.435), weight: 0.5},

  {location: new google.maps.LatLng(37.785, -122.447), weight: 3},
  {location: new google.maps.LatLng(37.785, -122.445), weight: 2},
  new google.maps.LatLng(37.785, -122.443),
  {location: new google.maps.LatLng(37.785, -122.441), weight: 0.5},
  new google.maps.LatLng(37.785, -122.439),
  {location: new google.maps.LatLng(37.785, -122.437), weight: 2},
  {location: new google.maps.LatLng(37.785, -122.435), weight: 3}
];

var sanFrancisco = new google.maps.LatLng(37.774546, -122.433523);

map = new google.maps.Map(document.getElementById('map'), {
  center: sanFrancisco,
  zoom: 13,
  //mapTypeId: 'satellite'
});

var heatmap = new google.maps.visualization.HeatmapLayer({
  data: heatMapData
});
heatmap.setMap(map);
}