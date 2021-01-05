import 'package:firstdemo/api/signApi.dart';
import 'package:firstdemo/model/RegModel.dart';
import 'package:firstdemo/screen/login.dart';
import 'package:firstdemo/widgets/customShape.dart';
import 'package:firstdemo/widgets/customappbar.dart';
import 'package:firstdemo/widgets/responsiveWidget.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  double _width;
  double _height;
  double _pixelRatio;
  bool _large;
  bool _medium;
  bool showSpinner = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();
  String rname = '';
  String rpassword = '';
  String userid = '';
  bool hidePassword = true;
  RegRequestModel rgrequestModel;
  @override
  void initState() {
    super.initState();
    rgrequestModel = new RegRequestModel();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return Material(
      child: Container(
        height: _height,
        width: _width,
        padding: EdgeInsets.only(bottom: 5),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Opacity(opacity: 0.88, child: CustomAppBar()),
              clipShape(),
              regTextRow(),
              form(),
              SizedBox(height: _height / 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget clipShape() {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: _large
                  ? _height / 8
                  : (_medium ? _height / 7 : _height / 6.5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange[200], Colors.pinkAccent],
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: ClipPath(
            clipper: CustomShapeClipper2(),
            child: Container(
              height: _large
                  ? _height / 12
                  : (_medium ? _height / 11 : _height / 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange[200], Colors.pinkAccent],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget welcomeTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 20, top: _height / 100),
      child: Row(
        children: <Widget>[],
      ),
    );
  }

  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0, right: _width / 12.0, top: _height / 15.0),
      child: Form(
        key: _key,
        child: Column(
          children: <Widget>[
            // emailTextFormField(),
            new TextFormField(
              keyboardType: TextInputType.emailAddress,
              // onSaved: (input) => requestModel.email = input,
              validator: (input) =>
                  !input.contains('@') ? "Email Id should be valid" : null,
              decoration: new InputDecoration(
                hintText: "Email Address",
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).accentColor.withOpacity(0.2))),
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).accentColor)),
                prefixIcon: Icon(
                  Icons.email,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
            SizedBox(height: _height / 40.0),

            new TextFormField(
              style: TextStyle(color: Theme.of(context).accentColor),
              keyboardType: TextInputType.text,
              // onSaved: (input) => requestModel.password = input,
              validator: (input) => input.length < 3
                  ? "Password should be more than 3 characters"
                  : null,
              obscureText: hidePassword,
              decoration: new InputDecoration(
                hintText: "Password",
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).accentColor.withOpacity(0.2))),
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).accentColor)),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Theme.of(context).accentColor,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      // hidePassword = !hidePassword;
                    });
                  },
                  color: Theme.of(context).accentColor.withOpacity(0.4),
                  icon: Icon(
                      hidePassword ? Icons.visibility_off : Icons.visibility),
                ),
              ),
            ),
            SizedBox(height: _height / 40.0),

//submit button

            FlatButton(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
              onPressed: () {
                if (validateAndSave()) {
                  RegApi apiService = new RegApi();
                  try {
                    apiService.register(rgrequestModel).then((value) {
                      print("Tocken");
                      print(value.token);
                      if (value.token.isNotEmpty) {
                        print("Succes");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SignInPage(), //Can Pass value.tocken
                          ),
                        );
                        print("Routing to Login  screen");
                      }
                    });
                  } catch (e) {
                    print(e);
                  }
                }
              },
              child: Text(
                "REGISTER",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.orange,
              shape: StadiumBorder(),
            )
            // passwordTextFormField()
          ],
        ),
      ),
    );
  }

  Widget regTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 20, top: _height / 100),
      child: Row(
        children: <Widget>[
          Text(
            "Register To DocBase",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,

              // fontSize: _large ? 40 : (_medium ? 50 : 40),
              fontSize: _large ? 40 : (_medium ? 40 : 40),
            ),
          ),
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
