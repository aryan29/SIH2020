// In this example, we center the map, and add a marker, using a LatLng object
// literal instead of a google.maps.LatLng object. LatLng object literals are
// a convenient way to add a LatLng coordinate and, in most cases, can be used
// in place of a google.maps.LatLng object.

var map;
function initMap() {
  var mapOptions = {
    zoom: 8,
    center: { lat: 23.2856, lng: 85.3059 }
  };
  map = new google.maps.Map(document.getElementById("map"), mapOptions);

  var marker = new google.maps.Marker({
    // The below line is equivalent to writing:
    // position: new google.maps.LatLng(-34.397, 150.644)
    icon: 'http://maps.google.com/mapfiles/ms/icons/red-dot.png',
    position: { lat: 23.2856,lng: 85.3059 },
    map: map
  });

  // You can use a LatLng literal in place of a google.maps.LatLng object when
  // creating the Marker object. Once the Marker object is instantiated, its
  // position will be available as a google.maps.LatLng object. In this case,
  // we retrieve the marker's position using the
  // google.maps.LatLng.getPosition() method.
  var infowindow = new google.maps.InfoWindow({
    content: "<p>Marker Location:" + marker.getPosition() + "</p>"
  });

  google.maps.event.addListener(marker, "click", function() {
    infowindow.open(map, marker);
  });


  var marker2 = new google.maps.Marker({
    // The below line is equivalent to writing:
    // position: new google.maps.LatLng(-34.397, 150.644)
    icon: 'http://maps.google.com/mapfiles/ms/icons/yellow-dot.png',
    position: { lat: 23.2856, lng: 85.3359 },
    map: map
  });

  // You can use a LatLng literal in place of a google.maps.LatLng object when
  // creating the Marker object. Once the Marker object is instantiated, its
  // position will be available as a google.maps.LatLng object. In this case,
  // we retrieve the marker's position using the
  // google.maps.LatLng.getPosition() method.
  var infowindow = new google.maps.InfoWindow({
    content: "<p>Marker Location:" + marker2.getPosition() + "</p>"
  });

  google.maps.event.addListener(marker2, "click", function() {
    infowindow.open(map, marker2);
  });

  var marker3 = new google.maps.Marker({
    // The below line is equivalent to writing:
    // position: new google.maps.LatLng(-34.397, 150.644)
    icon: 'http://maps.google.com/mapfiles/ms/icons/green-dot.png',
    position: { lat: 23.2756, lng: 85.3059 },
    map: map
  });

  // You can use a LatLng literal in place of a google.maps.LatLng object when
  // creating the Marker object. Once the Marker object is instantiated, its
  // position will be available as a google.maps.LatLng object. In this case,
  // we retrieve the marker's position using the
  // google.maps.LatLng.getPosition() method.
  var infowindow = new google.maps.InfoWindow({
    content: "<p>Marker Location:" + marker3.getPosition() + "</p>"
  });

  google.maps.event.addListener(marker3, "click", function() {
    infowindow.open(map, marker3);
  });
}