import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:my_app/src/my.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:math';
import 'package:flutter/painting.dart';

final String ip = "192.168.0.105";
class UserData extends StatefulWidget {
  static String email = "", pass = "";
  static int count = 0;
  static String defimg = "";
  UserData(email1, pass1) {
    email = email1;
    pass = pass1;
  }

  @override
  _UserDataState createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  void init(email) async {
    print("comig bro");
    try {
      print(email);
      print("Coming to Init for Basics");
      mongo.Db db = new mongo.Db("mongodb://$ip/registered");
      await db.open();
      print("success ---------------------------------");
      mongo.DbCollection coll = db.collection("credentials");
      var exist = await coll.find({"username": email}).toList();
      if (exist[0]['image'] != null) UserData.defimg = exist[0]['image'];
      if (exist[0]['press'] != null) UserData.count = exist[0]['press'];
      print(UserData.count);
      print(UserData.defimg);
      setState(() {
        UserData.defimg = UserData.defimg;
        UserData.count = UserData.count;
      });
      await db.close();
    } catch (e) {
      print(e);
    }
  }

  _UserDataState() {
    init(UserData.email);
  }
  Future<int> mongocount(email, pass) async {
    print("Coming to Getting Count");
    mongo.Db db = new mongo.Db("mongodb://$ip/registered");
    await db.open();
    print("success ---------------------------------");
    mongo.DbCollection coll = db.collection("credentials");
    var exist = await coll.find({"username": email}).toList();
    try {
      exist[0]['press'] = exist[0]['press'] + 1;
    } catch (error) {
      exist[0]['press'] = 1;
      print(error);
    }
    if (exist[0]['press'] is int) {
      print("Integer");
    } else {
      print("Something else it is");
    }
    print(exist[0]['press']);
    await coll.save(exist[0]);
    await db.close();
    return exist[0]['press'];
  }

  Future<String> setImage(ImageSource img, String email) async {
    File newimg;
    try {
      final imgFile = await ImagePicker.pickImage(source: img);
      Directory dir = await getApplicationDocumentsDirectory();
      final String path = dir.path;
      var rng = new Random();
      var code = rng.nextInt(900000) + 100000;
      newimg = await imgFile.copy("$path/$email$code.png");
    } catch (e) {
      print(e);
    }
    print("Coming to Set Image");
    mongo.Db db = new mongo.Db("mongodb://$ip/registered");
    await db.open();
    print("success ---------------------------------");
    mongo.DbCollection coll = db.collection("credentials");
    var exist = await coll.find({"username": email}).toList();
    try {
      exist[0]['image'] = newimg.path;
    } catch (error) {
      exist[0]['image'] = newimg.path;
    }
    await coll.save(exist[0]);
    await db.close();
    return newimg.path;
  }

 //Make User Page Front End Here
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(title: Text("Confirmation")),
      body: Container(
          child: Center(
              child: Column(
        children: <Widget>[
          Text("Login Credentails"),
          Text("Email  -> " + UserData.email),
          Text("Password  -> " + UserData.pass),
          Text("Count  -> " + UserData.count.toString()),
          RaisedButton(
            child: Text("Press Me", style: TextStyle(fontSize: 20.0)),
            onPressed: () {
              mongocount(UserData.email, UserData.pass).then((val) {
                setState(() {
                  UserData.count = val;
                });
              });
            },
          ),
          RaisedButton(
            child: Text("Logout", style: TextStyle(fontSize: 20.0)),
            onPressed: () {
              setState(() {
                UserData.email = "";
                UserData.pass = "";
                UserData.count = 0;
                UserData.defimg = "";
              });
            },
          ),
          RaisedButton(
            child: Text("Upload Your Photo here"),
            onPressed: () {
              return setImage(ImageSource.gallery, UserData.email).then((str) {
                setState(() {
                  print("Changing State");
                  print(str);
                  UserData.defimg = str;
                });
              });
            },
          ),
          Container(
            height: 100.0,
            width: 100.0,
            child: Builder(builder: (BuildContext context) {
              try {
                print(UserData.defimg);
                if (UserData.defimg != "") {
                  return Image.file(File(UserData.defimg));
                } else {
                  return Image.network("https://picsum.photos/250?image=9");
                }
              } catch (e) {
                print(e);
                return Image.network("https://picsum.photos/250?image=9");
              }
            }),
          )
        ],
      ))),
    );
  }
}
