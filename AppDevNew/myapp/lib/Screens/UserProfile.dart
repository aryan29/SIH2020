import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../GettingData/getUserInformation.dart';
import 'ShowContributions.dart';

class UserProfile1 extends StatefulWidget {
  UserProfile1({Key key}) : super(key: key);

  @override
  _UserProfile1State createState() => _UserProfile1State();
}

class _UserProfile1State extends State<UserProfile1> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  getDataFromSharedPref() async {
    await getUserInformation();
    final SharedPreferences prefs = await _prefs;
    return {
      "username": prefs.get("username"),
      "contribution": prefs.get("contribution")
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
            future: getDataFromSharedPref(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return Container(
                    // decoration: BoxDecoration(
                    //     image: DecorationImage(
                    //         fit: BoxFit.cover,
                    //         colorFilter: ColorFilter.mode(
                    //             Colors.white.withOpacity(0.7),
                    //             BlendMode.dstATop),
                    //         image: AssetImage("assets/hh.jpg"))
                    //         ),
                    child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 250,
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(snapshot.data["username"],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 10),
                              Text(snapshot.data["contribution"].toString(),
                                  style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 30),
                              Container(
                                child: FittedBox(
                                  child: MaterialButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ),
                                      height: 70,
                                      minWidth: 200,
                                      color: Colors.amber[100],
                                      hoverColor: Colors.yellow,
                                      focusColor: Colors.yellow,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text("Check your contributions",
                                              style: TextStyle(
                                                  color: Colors.amber[700],
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20)),
                                          Icon(Icons.chevron_right,
                                              color: Colors.amber[700])
                                        ],
                                      ),
                                      onPressed: () async {
                                        print("On tap detection");
                                        //(api/myimages/)
                                        //Will return list of all images upload by me sep by %
                                        //then I have to go to download/ for each single image
                                        //download/(Image Name)
                                        var data = await getMyImages();
                                        print(data);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        ShowContributions(
                                                            data: data)));
                                      }),
                                ),
                              ),
                              SizedBox(height: 50),
                              Container(
                                child: FittedBox(
                                  child: MaterialButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ),
                                      height: 70,
                                      minWidth: 200,
                                      color: Colors.amber[100],
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text("Edit Your Profile",
                                              style: TextStyle(
                                                  color: Colors.amber[700],
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20)),
                                          Icon(Icons.chevron_right,
                                              color: Colors.amber[700])
                                        ],
                                      ),
                                      onPressed: () async {}),
                                ),
                              )
                            ],
                          )),
                    ),
                    Positioned(
                      //  top:0.0,
                      //  left:0.0,
                      child: ClipPath(
                          clipper: ArcClipper(),
                          child: Container(
                            height: 300,
                            color: Colors.green[300],
                          )),
                    ),
                    Positioned(
                      top: 110,
                      left: MediaQuery.of(context).size.width / 2 - 50,
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.green.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 0))
                          ],
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(
                              color: Colors.white,
                              width: 5.0,
                              style: BorderStyle.solid),
                          color: Colors.green,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  "https://webstockreview.net/images/bandana-clipart-gangsta-15.jpg")),
                        ),
                      ),
                    ),
                  ],
                ));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
