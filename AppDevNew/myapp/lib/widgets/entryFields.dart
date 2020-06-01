import 'package:flutter/material.dart';

class EntryField extends StatelessWidget {
  final String text;
  const EntryField({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[300]))),
      child: TextField(
        decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
            hintText: text),
      ),
    );
  }
}
