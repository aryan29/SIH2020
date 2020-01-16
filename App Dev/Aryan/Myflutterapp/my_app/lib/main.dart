import 'dart:convert';
//import 'dart:html';
import 'dart:io';
//import 'dart:js';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

String FileName = "";
String Base64EncodeFile = "";
void main() => runApp(MyApp());

class Screen3 extends StatelessWidget {
  var defimg =
      "https://camo.githubusercontent.com/f8ea5eab7494f955e90f60abc1d13f2ce2c2e540/68747470733a2f2f662e636c6f75642e6769746875622e636f6d2f6173736574732f323037383234352f3235393331332f35653833313336322d386362612d313165322d383435332d6536626439353663383961342e706e67";
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            drawer: MyDrawer(),
            appBar: AppBar(
                title: Text("Multiple Tabs"),
                bottom: TabBar(
                  labelPadding: EdgeInsets.all(10.0),
                  indicatorColor: Colors.blueGrey,
                  //indicatorPadding: EdgeInsets.all(30.0),
                  tabs: <Widget>[Text("Trending News"), Text("Contact Us")],
                )),
            body: TabBarView(
              children: <Widget>[
                Container(
                    color: Colors.greenAccent,
                    child: Center(
                        child: Text(
                      "Some Trending News Here",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ))),
                SingleChildScrollView(
                  child: Container(
                      color: Colors.greenAccent,
                      padding: EdgeInsets.only(left: 150, top: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // padding:EdgeInsets.all(20),
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundImage: NetworkImage(
                                          "https://avatars3.githubusercontent.com/u/43298145?s=460&v=4"),
                                    ),
                                    Text("Aryan Khandelwal"),
                                    Text("Web Development"),
                                    Text("+917906224093")
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundImage: NetworkImage(defimg),
                                    ),
                                    Text("Rohan Nishant"),
                                    Text("App Development")
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundImage: NetworkImage(defimg),
                                    ),
                                    Text("Abhilasha Sinha"),
                                    Text("Machine Learning")
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundImage: NetworkImage(defimg),
                                    ),
                                    Text("Rashi Gupta"),
                                    Text("Web Development")
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundImage: NetworkImage(defimg),
                                    ),
                                    Text("Shrey Rai"),
                                    Text("Machine Learning")
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundImage: NetworkImage(defimg),
                                    ),
                                    Text("Amit Dutta"),
                                    Text("Machine Learning")
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                )
              ],
            )));
  }
}

class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Confirmation")),
      body: Container(
        child: Center(
            child:
                Text('We have informed the NGO about dirtyness in your area.')),
      ),
    );
  }
}

class Screen1 extends StatelessWidget {
  var y;
  Screen1(var x) {
    this.y = x;
    //print(this.y.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("NGOs List"),
        ),
        drawer: MyDrawer(),
        body: Container(
            color: Colors.white12,
            child: Center(
                child: ListView(
              children: <Widget>[
                for (int i = 0; i < this.y.length; i++)
                  ExpansionTile(
                    backgroundColor: Colors.black26,
                    title: Text("${i + 1} ${this.y[i]}"),
                    //onTap: () => change(),
                    // subtitle: Text("Location of NGO"),
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                              height: 30.0,
                              alignment: Alignment(-0.8, 0),
                              child: Text('Location'))
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                              height: 30.0,
                              alignment: Alignment(-0.8, 0),
                              child: Text("Mobile Number"))
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            height: 30.0,
                            alignment: Alignment(-0.8, 0),
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Screen2()),
                                );
                              },
                              child: Text('Contact Them'),
                              autofocus: false,
                              focusColor: Colors.black54,
                            ),
                            margin: const EdgeInsets.only(bottom: 20.0),
                          )
                        ],
                      )
                    ],
                  ),
              ],
            ))));
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Upload Page',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: MyHomePage(title: 'Select Image'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //final ImagePicker _imagePicker = ImagePickerChannel();

  File _imageFile;

  Future<void> captureImage(ImageSource imageSource) async {
    try {
      final imageFile = await ImagePicker.pickImage(source: imageSource);
      setState(() {
        _imageFile = imageFile;
      });
      FileName = _imageFile.path.split('/').last;
      Base64EncodeFile = base64Encode(_imageFile.readAsBytesSync());
      // print(FileName);
      // print(Base64EncodeFile);
    } catch (e) {
      print(e);
    }
  }

  Widget _buildImage() {
    if (_imageFile != null) {
      return Image.file(_imageFile);
    } else {
      return Text('Take an image to start', style: TextStyle(fontSize: 18.0));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          Expanded(child: Center(child: _buildImage())),
          _buildButtons(),
        ],
      ),
    );
  }

  myfunction() async {
    final String url = "http://aryan29.pythonanywhere.com/webserver/";
    //print("Hello World");
    // var response = await http.get(url);
    // print('Response status: ${response.body}');
    var location = new Location();
    try {
      var cl = await location.getLocation();
      print(cl.latitude);
      print(cl.longitude);
      await http.post(url, body: {
        // "image": Base64EncodeFile,
        // "image_name": FileName,
        "name": "aryan",
        "lat": cl.latitude.toString(),
        "lon": cl.longitude.toString(),
        "img": Base64EncodeFile,
        "imgname": FileName
      }).then((result) {
        print(result.statusCode);
        // print(result.body);
        // List<Item> myModels;
        // myModels = (json.decode(result.body) as List)
        //     .map((i) => MyModel.fromJson(i))
        //     .toList();
        Map<String, dynamic> user = jsonDecode(result.body);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Screen1(user['check']);
            }));

      });
    } on PlatformException catch (e) {
      print(e.code);
    }
  }
  Widget _buildButtons() {
    return ConstrainedBox(
        constraints: BoxConstraints.expand(height: 80.0),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildActionButton(
                key: Key('retake'),
                text: 'Photos',
                onPressed: () => captureImage(ImageSource.gallery),
              ),
              _buildActionButton(
                key: Key('upload'),
                text: 'Camera',
                onPressed: () => captureImage(ImageSource.camera),
              ),
              _buildActionButton(
                key: Key('send'),
                text: 'Upload',
                onPressed: () => myfunction(),
              ),
            ]));
  }

  Widget _buildActionButton({Key key, String text, Function onPressed}) {
    return Expanded(
      child: RaisedButton(
          key: key,
          child: Text(text, style: TextStyle(fontSize: 20.0)),
          shape: RoundedRectangleBorder(),
          color: Colors.black54,
          textColor: Colors.white,
          onPressed: onPressed),
    );
  }
}

class MyDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Container(
        child: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Navigate'),
            decoration: BoxDecoration(color: Colors.blue),
          ),
          ListTile(title: Text('Trending News'), onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Screen3();
            }));
          }),
          ListTile(
            title: Text('Contact Us'),
            onTap:() {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Screen3();
            }));
  }
          ),
          ListTile(
            title: Text('Home Page'),
            onTap: () {},
          ),
          ListTile(title: Text('Login/Signup'), onTap: () {}),
          ListTile(title: Text('Upload Image'), onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
            return MyApp();
            }));
          })
        ],
      ),
    ));
  }
}
