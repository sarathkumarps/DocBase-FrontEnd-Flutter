import 'dart:ffi';
import 'dart:math';

import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:firstdemo/model/loginModel.dart';

class LoginApi {
  Future<LoginResponseModel> login(LoginRequestModel loginRequestModel) async {
    String url = "https://reqres.in/api/login";
    final response = await Dio().post(url, data: loginRequestModel.toJson());
    print(" Token    ");
    print(response.data);
    if (response.statusCode == 200) {
      return LoginResponseModel.fromJson((response.data)); //Was Error
    } else if (response.statusCode == 400) {
      print(response.data);
      return LoginResponseModel.fromJson((response.data));
    } else {
      print(DioErrorType.RESPONSE);
      return LoginResponseModel.fromJson((response.data));
    }
  }
}
