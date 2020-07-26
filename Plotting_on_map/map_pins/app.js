// In this example, we center the map, and add a marker, using a LatLng object
// literal instead of a google.maps.LatLng object. LatLng object literals are
// a convenient way to add a LatLng coordinate and, in most cases, can be used
// in place of a google.maps.LatLng object.

var map;
function initMap() {
  var mapOptions = {
    zoom: 5,
    center: { lat: 30.2856, lng: 70.3059 }
  };
  map = new google.maps.Map(document.getElementById("map"), mapOptions);

  var data = [{"index": 2, "latitude": 80.0, "longitude": 50.0}, {"index": 3, "latitude": 27.0, "longitude": 90.0}, {"index": 8, "latitude": 31.14, "longitude": 75.54}, {"index": 3.5, "latitude": 31.0, "longitude": 75.5}, {"index": 7, "latitude": 31.14, "longitude": 72.54}, {"index": 10, "latitude": 31.0, "longitude": 70.5}];

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
