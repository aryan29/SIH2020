import 'package:flutter/material.dart';
import '../widgets/ListCard.dart';

class NearbyNGOs extends StatefulWidget {
  NearbyNGOs({Key key}) : super(key: key);

  @override
  _NearbyNGOsState createState() => _NearbyNGOsState();
}

class _NearbyNGOsState extends State<NearbyNGOs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return MListCard();
              })),
    );
  }
}
