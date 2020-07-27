import 'package:flutter/material.dart';

class ContactUs extends StatefulWidget {
  ContactUs({Key key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  Text("Contact Us",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30)),
                  Text(
                    "We are avilable 24hours in your service",
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                  SizedBox(height: 80),
                  TextField(
                    maxLines: 10,
                    decoration:
                        InputDecoration(filled: true, hintText: "Message"),
                  ),
                  SizedBox(height: 20),
                  MaterialButton(
                    child: Icon(Icons.send),
                    onPressed: () {
                      //Send Message to Our API Model
                    },
                  )
                ],
              ))),
    );
  }
}
