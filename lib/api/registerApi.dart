import 'package:dio/dio.dart';

Dio dio = Dio();
// var url = 'https://reqres.in/api/register';
var url = 'https://reqres.in/api/register';

class RegService {
  void regDio() async {
    try {
      Response response = await Dio().post(
        url,
      );
      print(response);
    } on Exception catch (e) {
      print(e);
    }
  }
}
