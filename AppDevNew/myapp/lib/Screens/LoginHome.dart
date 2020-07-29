import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'UserProfile.dart';
import 'uploadImage.dart';
import 'contactus.dart';
import 'Ngos.dart';

class LoginHome extends StatefulWidget {
  LoginHome({Key key}) : super(key: key);

  @override
  _LoginHomeState createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHome> {
  PageController controller = PageController();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
            ]),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 18),
              child: SafeArea(
                child: GNav(
                  selectedIndex: _selectedIndex,
                  gap: 8,
                  activeColor: Colors.green,
                  iconSize: 24,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                  duration: Duration(milliseconds: 800),
                  tabBackgroundColor: Colors.green[100],
                  tabs: [
                    GButton(
                      icon: Icons.home,
                      text: "home",
                      iconColor: Colors.grey[500],
                    ),
                    GButton(
                        icon: Icons.camera,
                        text: "upload",
                        iconColor: Colors.grey[500]),
                    GButton(
                        icon: Icons.list,
                        text: "NGOs",
                        iconColor: Colors.grey[500]),
                    GButton(
                        icon: Icons.contacts,
                        text: "Contacts",
                        iconColor: Colors.grey[500]),
                  ],
                  onTabChange: (index) {
                    print("here");
                    setState(() {
                      _selectedIndex = index;
                    });
                    controller.jumpToPage(index);
                  },
                ),
              ),
            )),
        body: PageView(
          onPageChanged: (page) {
            setState(() {
              _selectedIndex = page;
            });
          },
          controller: controller,
          children: <Widget>[
            UserProfile1(),
            Upload(),
            NearbyNGOs(),
            ContactUs()
          ],
        ));
  }
}
