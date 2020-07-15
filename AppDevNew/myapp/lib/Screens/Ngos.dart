import 'package:flutter/material.dart';
import 'package:myapp/GettingData/getUserInformation.dart';
import '../widgets/ListCard.dart';
import 'package:location/location.dart';

class NearbyNGOs extends StatefulWidget {
  NearbyNGOs({Key key}) : super(key: key);

  @override
  _NearbyNGOsState createState() => _NearbyNGOsState();
}

class _NearbyNGOsState extends State<NearbyNGOs> {
  myfunc() async {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _pstatus;
    LocationData _location_data;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
    }
    if (!_serviceEnabled) {
      return -1;
    }
    _pstatus = await location.hasPermission();

    if (_pstatus == PermissionStatus.denied) {
      _pstatus = await location.requestPermission();
    }
    if (_pstatus == PermissionStatus.denied) {
      return -1;
    }
    _location_data = await location.getLocation();
    double lat, lon;
    lat = _location_data.latitude;
    lon = _location_data.longitude;
    var data = await getNearbyNGO(lat, lon);
    // print(data);
    // print(data[0]);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: myfunc(),
          builder: (context, snapshot) {
            var data = snapshot.data;
            if (data != null && data != -1) {
              return Container(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: data['name'].length,
                      itemBuilder: (BuildContext context, int index) {
                        return MListCard(name: data['name'][index],address:data['address'][index],rating:data['rating'][index],icon:data['icons'][index]);
                      }));
            } else if (data == -1) {
              return Center(
                  child:
                      Text("Please Allow Location Permissions for us to work"));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
