import 'package:dio/dio.dart';

Dio dio = Dio();
// var url = 'https://reqres.in/api/register';
var url = 'https://reqres.in/api/users?page=2';

class RegService {
  void regDio() async {
    try {
      Response response = await Dio().get(url);
      print(response);
    } on Exception catch (e) {
      print(e);
    }
  }
}
