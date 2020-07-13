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
    return Container(
        child: ListView.builder(
            itemCount: widget.data.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  height: 200,
                  child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      progressIndicatorBuilder: (context, url, progress) =>
                          CircularProgressIndicator(value: progress.progress),
                      imageUrl:
                          "http://192.168.0.107:8000/download/${widget.data[index]}"));
            }));
  }
}
