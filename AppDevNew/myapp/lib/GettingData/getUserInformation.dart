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
  var res1 = await dio.get("https://ctrlaltelite.cf/api/users2/");
  var res2 = await dio.get("https://ctrlaltelite.cf/api/users1/");
  var res3 = await dio.get("https://ctrlaltelite.cf/api/getcontributions/");
  print(res3.data);
  prefs.setString("username", res1.data[0]["username"]);
  prefs.setString("first_name", res1.data[0]["first_name"]);
  prefs.setString("last_name", res1.data[0]["last_name"]);
  prefs.setString("email", res1.data[0]["email"]);
  prefs.setString("mob", res2.data[0]["mob"]);
  prefs.setString("address", res2.data[0]["address"]);
  prefs.setInt("contribution", res3.data);
}

getNearbyNGO(var lat, var lon) async {
  final storage = new FlutterSecureStorage();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String token = await storage.read(key: "token");
  // print(token);
  var dio = Dio();
  dio.options.headers["Authorization"] = "Token $token";
  FormData formData = FormData.fromMap({"lat": lat, "lon": lon});
  try {
    var res1 =
        await dio.post("https://ctrlaltelite.cf/api/ngoslist/", data: formData);
    // print(res1.data);
    return res1.data;
  } on DioError catch (e) {
    print("Something went wrong");
    return -1;
  }
}

getMyImages() async {
  print("Coming to get my images");
  final storage = new FlutterSecureStorage();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String token = await storage.read(key: "token");
  var dio = Dio();
  dio.options.headers["Authorization"] = "Token $token";
  var res1 = await dio.get("https://ctrlaltelite.cf/api/myimages/");
  print(res1.data);
  List<dynamic> li = res1.data;

  return li;
}
