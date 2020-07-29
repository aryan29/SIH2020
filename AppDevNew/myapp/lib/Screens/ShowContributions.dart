import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ShowContributions extends StatefulWidget {
  final data;
  ShowContributions({Key key, @required this.data}) : super(key: key);

  @override
  _ShowContributionsState createState() => _ShowContributionsState();
}

class _ShowContributionsState extends State<ShowContributions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: ListView(
        children: <Widget>[
          Container(
            height: 150,
            color: Colors.green,
            child: Center(
              child: Text("Your Contributions",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      // decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: widget.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    height: 200,
                    padding: EdgeInsets.all(20),
                    child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (context, url, progress) =>
                            Center(
                                child: CircularProgressIndicator(
                                    value: progress.progress)),
                        imageUrl:
                            "http://192.168.0.107:8000/download/${widget.data[index]}"));
              }),
        ],
      )),
    );
  }
}
