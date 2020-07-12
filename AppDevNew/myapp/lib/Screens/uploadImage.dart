import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import '../GettingData/sendingImage.dart';
import 'package:location/location.dart';

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  File _imageFile;
  bool sending = false;
  final picker = ImagePicker();
  Future<void> captureImage(ImageSource imageSource) async {
    try {
      final imageFile = await picker.getImage(source: imageSource);
      print(imageFile.path);
      setState(() {
        _imageFile = File(imageFile.path);
      });
    } catch (e) {
      print(e);
    }
  }

  sendImage() async {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _pstatus;
    LocationData _location_data;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
    }
    if (!_serviceEnabled) {
      return;
    }
    _pstatus = await location.hasPermission();

    if (_pstatus == PermissionStatus.denied) {
      _pstatus = await location.requestPermission();
    }
    if (_pstatus == PermissionStatus.denied) {
      return;
    }
    _location_data = await location.getLocation();
    double lat, lon;
    lat = _location_data.latitude;
    lon = _location_data.longitude;
    setState(() {
      sending = true;
    });
    var res = await sendingImage(_imageFile, lat, lon);
    setState(() {
      sending = false;
    });
    if (res == -1)
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Something Went Wrong")));
    else if (res == 0)
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("We cant't find Grabage in your image")));
    else
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Thanks for contributing")));
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Column(
          children: <Widget>[
            InkWell(
                onTap: () => captureImage(ImageSource.camera),
                child: Icon(Icons.camera,
                    size: 120, color: Color.fromRGBO(48, 154, 187, 1))),
            Text(
              "Upload from Camera",
              style: TextStyle(fontWeight: FontWeight.w400),
            )
          ],
        ),
        Column(
          children: <Widget>[
            InkWell(
                onTap: () => captureImage(ImageSource.gallery),
                child: Icon(Icons.image,
                    size: 120, color: Color.fromRGBO(48, 154, 187, 1))),
            Text("Upload from Gallery",
                style: TextStyle(fontWeight: FontWeight.w400))
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width * .6,
          height: 50,
          child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              color: Color.fromRGBO(48, 154, 187, .4),
              child: (sending)
                  ? Center(child: CircularProgressIndicator())
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Upload",
                            style: TextStyle(
                                color: Color.fromRGBO(48, 154, 187, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                        Icon(Icons.chevron_right,
                            color: Color.fromRGBO(48, 154, 187, 1))
                      ],
                    ),
              onPressed: () => sendImage()),
        ),
      ],
    ));
  }
}
