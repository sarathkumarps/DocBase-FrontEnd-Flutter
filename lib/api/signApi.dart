import 'package:dio/dio.dart';
import 'package:firstdemo/model/RegModel.dart';

class RegApi {
  Future<RegResponseModel> register(
      RegRequestModel registerRequestModel) async {
    var url = 'https://reqres.in/api/register';
    final response = await Dio()
        .post(url, data: {"email": "eve.holt@reqres.in", "password": "pistol"});
    //  final response = await Dio().post(url, data: registerRequestModel.toJson());
    print("Tocken");
    print(response.data);
    if (response.statusCode == 200) {
      print("Success");
      return RegResponseModel.fromJson((response.data)); //Was Error
    } else if (response.statusCode == 400) {
      print(response.data);
      print("Success but no data");
      return RegResponseModel.fromJson((response.data));
    } else {
      throw Exception("Cant Reach Data");
    }
  }
}
