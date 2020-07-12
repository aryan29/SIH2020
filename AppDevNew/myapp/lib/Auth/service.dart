import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

getAuthToken(String username, String password) async {
  final storage = new FlutterSecureStorage();
  var dio = Dio();
  try {
    var res = await dio.post("http://192.168.0.107:8000/api-token-auth/",
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

registerUser(String username, String password1, String password2, String email,
    String address, String mob) async {
  var dio = Dio();
  dio.options.headers['content-type'] = "application/json";
  print(username);
  FormData formData = new FormData.fromMap({
    "username": username,
    "password1": password1,
    "password2": password2,
    "email": email,
    "mob": mob,
    "address": address,
    "choice": "AppUsers"
  });
  try {
    var res =
        await dio.post("http://192.168.0.107:8000/register/", data: formData);
    if (res.statusCode == 200) {
      return 1;
    } else
      return 0;
  } on DioError catch (e) {
    print("Something Went Wrong");
    print(e);
    return 0;
  }
}
