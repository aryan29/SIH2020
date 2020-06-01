import 'package:flutter/material.dart';
import '../blocs/bloc1.dart';

class EntryField extends StatefulWidget {
  final String text;
  const EntryField({Key key, this.text}) : super(key: key);

  @override
  _EntryFieldState createState() => _EntryFieldState();
}

class _EntryFieldState extends State<EntryField> {
  final titleController = TextEditingController();
  @override
  void initState() {
    super.initState();
    titleController.addListener(() {
    // print(widget.text);
    // print(titleController.text);
    store.set(widget.text, titleController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[300]))),
      child: TextField(
        controller: titleController,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
            hintText: widget.text),
      ),
    );
  }
}
