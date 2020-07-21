import '../Animations/FadeAnimation.dart';
import 'package:flutter/material.dart';
import '../widgets/entryFields.dart';
import 'package:page_transition/page_transition.dart';
import 'LoginPage.dart';
import '../Auth/service.dart';
import '../blocs/bloc1.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool registering = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromRGBO(3, 9, 23, 1),
      body: Builder(builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.7), BlendMode.dstATop),
                  fit: BoxFit.cover,
                  image: AssetImage('assets/1.jpg'))),
          alignment: Alignment.topLeft,
          padding: EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 120),
                FadeAnimation(
                    1.2,
                    Text(
                      "Register",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: 30,
                ),
                FadeAnimation(
                    1.5,
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Column(
                        children: <Widget>[
                          EntryField(text: "Username"),
                          EntryField(text: "First Name"),
                          EntryField(text: "Last Name"),
                          EntryField(text: "Email"),
                          EntryField(text: "Mobile Number"),
                          EntryField(text: "Address"),
                          EntryField(text: "Password"),
                          EntryField(text: "Confirm Password"),
                        ],
                      ),
                    )),
                SizedBox(
                  height: 40,
                ),
                FadeAnimation(
                    1.8,
                    Center(
                      child: InkWell(
                        onTap: () async {
                          setState(() {
                            registering = true;
                          });

                          var res = await registerUser(
                            store.get("Username"),
                            store.get("First Name"),
                            store.get("Last Name"),
                            store.get("Password"),
                            store.get("Confirm Password"),
                            store.get("Email"),
                            store.get("Address"),
                            store.get("Mobile Number"),
                          );
                          if (res == 0) {
                            setState(() {
                              registering = false;
                            });
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("Something Went Wrong")));
                          } else if (res == 1) {
                            setState(() {
                              registering = false;
                            });
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Successfully Registered Please Check out your email")));
                          } else {
                            setState(() {
                              registering = false;
                            });
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("Please Check your details")));
                            print(res);
                            return showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Errors"),
                                  content: Column(children: [
                                    for (var k in res.keys)
                                      Container(
                                          child:
                                              Text(k + " " + res[k][0] + "\n",
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                  )))
                                  ]),
                                  actions: <Widget>[
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Back"))
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: Container(
                          width: 120,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.green[800]),
                          child: (registering)
                              ? Center(child: CircularProgressIndicator())
                              : Center(
                                  child: Text(
                                  "Register",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(.7)),
                                )),
                        ),
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                FadeAnimation(
                    2.0,
                    Center(
                      child: InkWell(
                        onTap: () {
                          print("Tapped");
                          Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: LoginPage(),
                                  duration: Duration(seconds: 2)));
                        },
                        child: Container(
                            width: 120,
                            height: 20,
                            child: Center(
                              child: Text("Login",
                                  style: TextStyle(
                                      fontSize: 13,
                                      decoration: TextDecoration.underline,
                                      color: Colors.black)),
                            )),
                      ),
                    ))
              ],
            ),
          ),
        );
      }),
    );
  }
}
