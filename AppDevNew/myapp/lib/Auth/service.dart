import 'dart:io';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

getAuthToken(String username, String password) async {
  final storage = new FlutterSecureStorage();
  var dio = Dio();
  try {
    var res = await dio.post("https://ctrlaltelite.cf/api-token-auth/",
        data: {"username": username, "password": password});
    print(res.data);
    print(res.data['token']);
    await storage.write(key: "token", value: res.data['token']);
    return 1;
  } on DioError catch (e) {
    print("Something Went Wrong");
    print(e);
    return 0;
  }
}

registerUser(String username, String fn, String ln, String password1,
    String password2, String email, String address, String mob) async {
  var dio = Dio();
  dio.options.headers['content-type'] = "application/json";
  print(username);
  FormData formData = new FormData.fromMap({
    "username": username,
    "first_name": fn,
    "last_name": ln,
    "password1": password1,
    "password2": password2,
    "email": email,
    "mob": mob,
    "address": address,
    "choice": "AppUsers"
  });
  try {
    var res = await dio.post("https://ctrlaltelite.cf/api/register/",
        data: formData);
    // print("working");
    // print(res.data.runtimeType);
    // print(res.statusCode);
    Map data = json.decode(res.data);
    if (data["status"] == 1) {
      // print("Returning right thing");
      return 1;
    } else {
      // print("here I am");
      return data["errors"];
    }
  } on DioError catch (e) {
    print("Something Went Wrong");
    print(e);
    return 0;
  }
}
