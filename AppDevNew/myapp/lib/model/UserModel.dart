import 'package:flutter/material.dart';

class User {
  String username, fname, lname, address, mobile;
  int contributions;
  Image profileImage;
  User(
      {this.username,
      this.fname,
      this.lname,
      this.address,
      this.mobile,
      this.contributions,
      this.profileImage
      });
}
