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
    String getHintText(String s) {
      if (s == "Username")
        return "Enter your Unique UserId";
      else if (s == "Email")
        return "Enter Your Email";
      else if (s == "Mobile Number")
        return "Ex:- +917906224093";
      else if (s == "Password")
        return "Password";
      else
        return widget.text;
    }

    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[300]))),
      child: TextField(
        obscureText:
            (widget.text == "Password" || widget.text == "Confirm Password")
                ? true
                : false,
        controller: titleController,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
            hintText: getHintText(widget.text)),
      ),
    );
  }
}
