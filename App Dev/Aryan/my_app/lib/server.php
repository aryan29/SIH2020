import 'dart:convert';
//import 'dart:html';
import 'dart:io';
//import 'dart:js';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "News Page",
        home: DefaultTabController(
          length: 2,
          child: Scaffold(),
        ));
  }
}
