import 'package:dio/dio.dart';
import 'package:firstdemo/api/doctorsListApi.dart';
import 'dart:convert';

List<Datum> list;
Dio dio = Dio();
var url = 'https://reqres.in/api/users';

class DoctorServices {
  static Future<List<Datum>> getDoctors() async {
    Response response = await dio.get(url,
        options: Options(responseType: ResponseType.plain)); //dio import  ...
    print("Response Code");

    print(response.statusCode);

    print("Response From API 1 ");
    print(response);

    try {
      if (response.statusCode == 200) {
        //Success
        var data = json.decode(response.data);
        // Map<String, dynamic> doctors = Datum.fromJson(response.toString());
        // List<Datum> doctorData = doctors["data"];
        var rest = data["data"] as List;
        print("Response From API 2 ");
        list = rest.map<Datum>((json) => Datum.fromJson(json)).toList();

        // print(doctorData);
        print("List Size :${list.length}");
        return list;
      } else {
        return null;
      }
    } on Exception catch (e) {
      print(e);
    }
  }
}
