import 'package:flutter/material.dart';
import '../GettingData/sendingImage.dart';

class ContactUs extends StatefulWidget {
  ContactUs({Key key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  TextEditingController mycontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 50),
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
                    controller: mycontroller,
                    maxLines: 10,
                    decoration:
                        InputDecoration(filled: true, hintText: "Message"),
                  ),
                  SizedBox(height: 20),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.grey[200],
                    child: Icon(Icons.send),
                    onPressed: () async {
                      print("Button Pressed");
                      print(mycontroller.text);
                      var res = await sendingQuery(mycontroller.text);
                      if (res == 1) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "We have received your query we will contact you soon")));
                      } else {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text("Something Went Wrong")));
                      }
                    },
                  )
                ],
              ))),
    );
  }
}
