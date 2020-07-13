import 'package:flutter/material.dart';

class MListCard extends StatefulWidget {
  final String name;
  final String address;
  final rating;
  final String icon;
  MListCard(
      {Key key,
      @required this.name,
      @required this.address,
      @required this.rating,
      @required this.icon})
      : super(key: key);

  @override
  _MListCardState createState() => _MListCardState();
}

class _MListCardState extends State<MListCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Colors.black,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        elevation: 2.0,
        margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 7.0),
        child: Container(
            child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          leading: Container(
              padding: EdgeInsets.only(right: 5.0),
              decoration: BoxDecoration(
                border:
                    Border(right: BorderSide(width: 1.0, color: Colors.white)),
              ),
              child: Image.network(widget.icon)),
          title: Text(
            widget.name,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          subtitle: Row(
            children: <Widget>[
              Icon(Icons.linear_scale, color: Colors.yellow),
              SizedBox(width: 10),
              Flexible(
                child: Text(
                  widget.address,
                  overflow: TextOverflow.clip,
                  softWrap: false,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          trailing:
              Icon(Icons.keyboard_arrow_right, size: 30.0, color: Colors.white),
        )),
      ),
    );
  }
}
