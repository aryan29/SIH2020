import '../Animations/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'signup.dart';
import '../Auth/service.dart';
import 'LoginHome.dart';
import '../widgets/entryFields.dart';
import 'package:page_transition/page_transition.dart';
import '../blocs/bloc1.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 9, 23, 1),
      body: Builder(
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FadeAnimation(
                    1.2,
                    Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
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
                          EntryField(text: "Password"),
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
                          print("Tapped");
                          int res = await getAuthToken(
                              store.get("Username"), store.get("Password"));
                          print("First Executed");
                          if (res == 1) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginHome()));
                          } else {
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text("Something Went Wrong")));
                          }
                        },
                        child: Container(
                          width: 120,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.blue[800]),
                          child: Center(
                              child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white.withOpacity(.7)),
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
                          Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: SignupPage(),
                                  duration: Duration(seconds: 2))
                                  );
                        },
                        child: Container(
                            width: 120,
                            height: 20,
                            child: Center(
                              child: Text("Register",
                                  style: TextStyle(
                                      fontSize: 13,
                                      decoration: TextDecoration.underline,
                                      color: Colors.white)),
                            )),
                      ),
                    ))
              ],
            ),
          );
        }
      ),
    );
  }
}
