//Rate the NGOs Page
import 'dart:collection';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:my_app/src/my.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:math';
import 'package:flutter/painting.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'user.dart';

final String ip = "192.168.0.105";

class NgoRate extends StatefulWidget {
  NgoRate({Key key}) : super(key: key);

  @override
  _NgoRateState createState() => _NgoRateState();
}

class _NgoRateState extends State<NgoRate> {
  List<String> ngos = ["arena", "bloot", "iona", "jooq", "ljuio"];
  HashMap mp = new HashMap<String, int>();
  Future<void> mongoUpdateRating(email, ngoname, rating) async {
    print("Coming to Mongo Update Rating");
    mongo.Db db = new mongo.Db("mongodb://$ip/registered");
    await db.open();
    print("success ---------------------------------");
    mongo.DbCollection coll = db.collection("ratings");
    var exist = await coll.find({"name": ngoname}).toList();
    if (exist[0].containsKey("avgRating")) {
      if (exist[0].containsKey(email)) {
        //This User is Rating this NGO again
        exist[0]['avgRating'] = (exist[0]['avgRating'] * exist[0]['rateCount'] -
                exist[0][email] +
                rating) /
            (exist[0]['rateCount']);
        exist[0]['email'] = rating;
      } else {
        //This User is Rating this NGO first time
        exist[0]['avgRating'] =
            (exist[0]['avgRating'] * exist[0]['rateCount'] + rating) /
                (exist[0]['rateCount'] + 1);
        exist[0]['email'] = rating;
      }
    } else {
      //This NGO will be rated first time
      exist[0]['avgRating'] = rating;
      exist[0]['rateCount'] = 1;
      exist[0]['email'] = rating;
    }
    print(exist[0]['avgRating'] + " " + exist[0]['email']);
    await coll.save(exist[0]);
    await db.close();
  }

  RatingBar getrating(String ngoname) {
    return RatingBar(
      initialRating: 3,
      itemCount: 5,
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return Icon(
              Icons.sentiment_very_dissatisfied,
              color: Colors.red,
            );
          case 1:
            return Icon(
              Icons.sentiment_dissatisfied,
              color: Colors.redAccent,
            );
          case 2:
            return Icon(
              Icons.sentiment_neutral,
              color: Colors.amber,
            );
          case 3:
            return Icon(
              Icons.sentiment_satisfied,
              color: Colors.lightGreen,
            );
          case 4:
            return Icon(
              Icons.sentiment_very_satisfied,
              color: Colors.green,
            );
        }
      },
      onRatingUpdate: (rating) {
        //Updated Ratig for Current NGO
        print("Rating Updated for NGO $ngoname to $rating");
        mp[ngoname] = rating;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(title: Text("Rate The NGOs")),
      body: Container(
          child: ListView(
        children: <Widget>[
          for (int i = 0; i < ngos.length; i++)
            ExpansionTile(
              backgroundColor: Colors.black26,
              title: Text("${i + 1} ${ngos[i]}"),
              //Also show Avg Rating with this to be Added
              children: <Widget>[
                getrating(ngos[i]),
                RaisedButton(
                  onPressed: () {
                    //Grab the name of the NGO and update its rating
                    //for this particular user and also change its average rating
                    //Dtabase Style
                    //NGO Name
                    //Each Username and Rating given by him
                    //Avg Rating of Each NGO
                    mongoUpdateRating(UserData.email, ngos[i], mp[ngos[i]]);
                  },
                  child: Text("Submit"),
                )
              ],
            ),
        ],
      )),
    ));
  }
}
