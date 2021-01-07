import 'dart:async';

import 'package:firstdemo/screen/doctorList.dart';
import 'package:firstdemo/screen/login.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String finalToken;

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedToken = sharedPreferences.getString("token");
    setState(() {
      finalToken = obtainedToken;
    });
    print("finalToken");
    print(finalToken);
    if (finalToken == null) {
      print("No token");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignInPage()));
    } else {
      print("Has Token");
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DoctorList()), //Can Pass value.tocken
      );
    }
  }

  // void navigationPage() {

  // }

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 4),
      () => getValidationData(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.blue[900]),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 80,
                        child: Icon(
                          Icons.supervised_user_circle_outlined,
                          color: Colors.orange,
                          size: 150,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 100),
                      ),
                      Text(
                        "DOCBASE",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                    ],
                  ))
            ],
          )
        ],
      ),
    );
  }
}
