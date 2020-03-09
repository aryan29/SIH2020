import 'dart:convert';
//import 'dart:html';
import 'dart:io';
//import 'dart:js';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:my_app/src/user.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import '../main.dart';
import 'user.dart';

final String ip = "192.168.0.105";
String FileName = "";
String Base64EncodeFile = "";
void main() => runApp(MyApp1());

class Screen3 extends StatelessWidget {
  var defimg = "https://ajwtu.nl/wp-content/uploads/2018/06/Stockperson.jpg";
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
                  indicatorColor: Colors.pink,
                  //indicatorPadding: EdgeInsets.all(30.0),
                  tabs: <Widget>[Text("Trending News"), Text("Contact Us")],
                )),
            body: TabBarView(
              children: <Widget>[
                Container(
                    color: Color.fromARGB(255, 194, 175, 206),
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
                      color: Color.fromARGB(255, 194, 175, 206),
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
                                          "https://qphs.fs.quoracdn.net/main-thumb-372975505-200-edfzxjdkfphnftaxkrmcxpkaakopplja.jpeg"),
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

class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Upload Page',
      theme: ThemeData(primaryColor: Colors.redAccent),
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

  uploadcontributions() async {
    if (UserData.email != "") {
      print("Coming to Uploading Contributions");
      mongo.Db db = new mongo.Db("mongodb://$ip/registered");
      await db.open();
      print("success ---------------------------------");
      mongo.DbCollection coll = db.collection("credentials");
      var exist = await coll.find({"username": UserData.email}).toList();
      try {
        exist[0]['contributions'] += 1;
      } catch (e) {
        exist[0]['contributions'] = 1;
      }
    await coll.save(exist[0]);
    await db.close();
    }
  }

  myfunction() async {
    //Use Base64EncodedImage to Check if Contributions should be updated or not
    uploadcontributions();
    final String url = "http://aryan29.pythonanywhere.com/webserver/";
    var location = new Location();
    try {
      var cl = await location.getLocation();
      print(cl.latitude);
      print(cl.longitude);
      await http.post(url, body: {
        "name": "aryan",
        "lat": cl.latitude.toString(),
        "lon": cl.longitude.toString(),
        "img": Base64EncodeFile,
        "imgname": FileName
      }).then((result) {
        print(result.statusCode);
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
          color: Colors.black87,
          textColor: Colors.white,
          onPressed: onPressed),
    );
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Image getimg() {
    if (UserData.defimg == "")
      return Image.network(
        "https://picsum.photos/250?image=9",
        fit: BoxFit.cover,
        height: 80,
        width: 80,
      );
    else
      return Image.file(
        File(UserData.defimg),
        fit: BoxFit.cover,
        height: 80,
        width: 80,
      );
  }

  Widget build(BuildContext context) {
    return Container(
        child: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Center(
                child:
                    CircleAvatar(radius: 40, child: ClipOval(child: getimg()))),
            decoration: BoxDecoration(color: Colors.redAccent),
          ),
          ListTile(
              title: Text('Trending News'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Screen3();
                }));
              }),
          ListTile(
              title: Text('Contact Us'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Screen3();
                }));
              }),
          ListTile(
              title: Text('My Profile'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  if (UserData.email != "") {
                    return UserData(UserData.email, UserData.pass);
                  } else {
                    return MyApp();
                  }
                }));
              }),
          ListTile(
            title: Text('Home Page'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MyApp2();
              }));
            },
          ),
          ListTile(
              title: Text('Login/Signup'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MyApp();
                }));
              }),
          ListTile(
              title: Text('Upload Image'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MyApp1();
                }));
              })
        ],
      ),
    ));
  }
}
