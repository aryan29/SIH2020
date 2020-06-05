import '../model/UserModel.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

getUserInformation() async {
  print("Coming to get User Information");
  final storage = new FlutterSecureStorage();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  String token = await storage.read(key: "token");
  print(token);
  var dio = Dio();
  dio.options.headers["Authorization"] = "Token $token";
  var res1 = await dio.get("http://192.168.0.107:8000/api/users2/");
  var res2 = await dio.get("http://192.168.0.107:8000/api/users1/");
  await prefs.setString("username", res1.data[0]["username"]);
  prefs.setString("first_name", res1.data[0]["first_name"]);
  prefs.setString("last_name", res1.data[0]["last_name"]);
  prefs.setString("email", res1.data[0]["email"]);
  prefs.setString("mob", res2.data[0]["mob"]);
  prefs.setString("address", res2.data[0]["address"]);
}
