import 'package:flutter/material.dart';

class GarbageImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var garbageImage = new AssetImage('assets/garbage_pic.png');
    var garbage_image = new Image(
      image: garbageImage,
      width: 600.0,
      height: 100.0,
    );
    return new Container(
      child: garbage_image,
    );
  }
}

class NGOImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var buildingImage = new AssetImage('assets/ngo_building.png');
    var ngo_image = new Image(
      image: buildingImage,
      width: 600.0,
      height: 100.0,
    );
    return new Container(
      child: ngo_image,
    );
  }
}

class PastImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
var PastImage = new AssetImage('assets/past.png');
var past_image = new Image(
image: PastImage,
width: 600.0,
height: 100.0,
);
return new Container(
child: past_image,
);
  }
}
