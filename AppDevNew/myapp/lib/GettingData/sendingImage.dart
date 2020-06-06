import '../model/UserModel.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

sendingImage(File file) async {
  print("Coming to get Sending Image");
  final storage = new FlutterSecureStorage();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String token = await storage.read(key: "token");
  // print(token);
  var dio = Dio();
  dio.options.headers['content-type'] = "multipart/form-dataitem";
  dio.options.headers["Authorization"] = "Token $token";
  String filename = file.path.split('/').last;
  FormData formData = FormData.fromMap(
      {"file": await MultipartFile.fromFile(file.path, filename: filename)});
  try {
    var res1 = await dio.post("http://192.168.0.107:8000/api/checkimage/",
        data: formData);
    return res1.data;
  } on DioError catch (e) {
    print("Something went wrong");
    return -1;
  }
}
