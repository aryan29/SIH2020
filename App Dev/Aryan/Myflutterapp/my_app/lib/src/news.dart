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

class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Confirmation")),
      body: Container(
        child: Center(
          child:
          Text('We have informed the NGO about dirtyness in your area.')
          ),
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
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context)=>Screen2()),
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
        //print(user['check']);

        //var x = "hello";
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
