import 'dart:ffi';

import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:firstdemo/model/loginModel.dart';

class LoginApi {
  Future<LoginResponseModel> login(LoginRequestModel loginRequestModel) async {
    String url = "https://reqres.in/api/login";
    final response = await Dio().post(url, data: loginRequestModel.toJson());
    if (response.statusCode == 200) {
      return LoginResponseModel.fromJson(json.decode(response.data));
    } else if (response.statusCode == 400) {
      print("User Not Found");
      print(response.data);
      return LoginResponseModel.fromJson(json.decode(response.data));
    }
    return null;
  }
}