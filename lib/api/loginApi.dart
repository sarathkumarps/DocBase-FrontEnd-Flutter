import 'package:dio/dio.dart';

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
    } else {
      print("Error");
      throw Exception("Cant Reach Data");
      // return LoginResponseModel.fromJson((response.data));
    }
  }
}
