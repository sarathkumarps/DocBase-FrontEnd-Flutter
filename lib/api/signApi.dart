import 'package:dio/dio.dart';
import 'package:firstdemo/model/RegModel.dart';

class RegApi {
  Future<RegResponseModel> register(
      RegRequestModel registerRequestModel) async {
    var url = 'https://reqres.in/api/register';
    final response = await Dio().post(url, data: registerRequestModel.toJson());
    print("Tocken");
    print(response.data);
    if (response.statusCode == 200) {
      return RegResponseModel.fromJson((response.data)); //Was Error
    } else if (response.statusCode == 400) {
      print(response.data);
      return RegResponseModel.fromJson((response.data));
    } else {
      print(DioErrorType.RESPONSE);
      return RegResponseModel.fromJson((response.data));
    }
  }
}
