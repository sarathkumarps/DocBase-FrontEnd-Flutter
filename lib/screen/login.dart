import 'package:firstdemo/api/loginApi.dart';
import 'package:firstdemo/model/loginModel.dart';
import 'package:firstdemo/screen/doctorList.dart';
import 'package:firstdemo/screen/signUp.dart';
import 'package:firstdemo/widgets/customShape.dart';
import 'package:firstdemo/widgets/progressHUD.dart';
import 'package:firstdemo/widgets/responsiveWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignInScreen(),
    );
  }
}

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  bool hidePassword = true;
  bool isApiCallProcess = false;
  bool showSpinner = false;

  GlobalKey<FormState> _key = GlobalKey();
  String name = '';
  String password = '';
  // bool showSpinner = false;
  LoginRequestModel requestModel;

  @override
  void initState() {
    super.initState();
    requestModel = new LoginRequestModel();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _loginui(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }

  @override
  Widget _loginui(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Material(
        child: Container(
          height: _height,
          width: _width,
          padding: EdgeInsets.only(bottom: 5),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                clipShape(),
                welcomeTextRow(),
                signInTextRow(),
                form(),
                SizedBox(height: _height / 12),
                // button(),
                signUpTextRow(),
                SizedBox(height: _height / 25),
              ],
            ),
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
                  ? _height / 4
                  : (_medium ? _height / 3.75 : _height / 3.5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange[200], Colors.pinkAccent],
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.8,
          child: ClipPath(
            clipper: CustomShapeClipper2(),
            child: Container(
              height: _large
                  ? _height / 4.5
                  : (_medium ? _height / 4.25 : _height / 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange[200], Colors.pinkAccent],
                ),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          // color: Colors.orange,
          margin: EdgeInsets.only(
              top: _large
                  ? _height / 30
                  : (_medium ? _height / 25 : _height / 20)),

          // height: _height / 3.5, width: _width / 3.5,
          height: _height / 3, width: _width / 3,
          // fit: BoxFit.fill
        ),
      ],
    );
  }

  Widget welcomeTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 20, top: _height / 100),
      child: Row(
        children: <Widget>[
          Text(
            "Welcome To DocBase",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,

              // fontSize: _large ? 40 : (_medium ? 50 : 40),
              fontSize: _width / 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget signInTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 15.0),
      child: Row(
        children: <Widget>[
          Text(
            "Sign in to your account",
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: _large ? 20 : (_medium ? 17.5 : 15),
            ),
          ),
        ],
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
              onSaved: (input) => requestModel.email = input,
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
              onSaved: (input) => requestModel.password = input,
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
              onPressed: () async {
                final SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                if (validateAndSave()) {
                  setState(() {
                    // isApiCallProcess = true;
                  });

                  print(" Details ");
                  print(requestModel.toJson()); //Working

                  LoginApi apiService = new LoginApi();

                  apiService.login(requestModel).then(
                    (value) {
                      setState(() {
                        isApiCallProcess = false;
                      });
                      //Error
                      print("Geting Tocken");
                      print(value.token);
                      sharedPreferences.setString("token", value.token);
                      if (value.token.isNotEmpty) {
                        print("succees");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DoctorList()), //Can Pass value.tocken
                        );
                        print("Routing to Doctor up screen");
                      } else {
                        setState(() {
                          isApiCallProcess = false;
                        });
                      }
                    },
                  );
                } else {
                  print("ERROR");
                  setState(() {
                    isApiCallProcess = false;
                  });
                }
              },
              child: Text(
                "LOGIN",
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

  Widget signUpTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 120.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Text(
            "Create New Account",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: _large ? 14 : (_medium ? 12 : 10)),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUp()),
              );
              print("Routing to Sign up screen");
            },
            child: Text(
              "Sign up",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.orange[200],
                  fontSize: _large ? 19 : (_medium ? 17 : 15)),
            ),
          )
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
