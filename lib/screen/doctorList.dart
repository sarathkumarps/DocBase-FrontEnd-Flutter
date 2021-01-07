import 'package:firstdemo/api/doctorServicesApi.dart';
import 'package:firstdemo/api/doctorsListApi.dart';
import 'package:firstdemo/screen/chatScreen.dart';
import 'package:firstdemo/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorList extends StatefulWidget {
  @override
  _DoctorListState createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  //

  List<Datum> _doctors;
  ScrollController _scrollController = ScrollController();
  int currentMax = 5;
  int pageNumber = 1;
  bool isLoading = false;

  @override
  void initState() {
    pageNumber = 1;
    super.initState();
    DoctorServices.getDoctors().then((doctors) {
      setState(() {
        _doctors = doctors;
        _scrollController.addListener(() {
          if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
            _getMoreData();
          }
        });
      });
    });
  }

  _getMoreData() {
    print("Get More ");
    isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            title: Text(
              "Available Doctors",
              style: TextStyle(color: Colors.white),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: FlatButton(
                        color: Colors.orange,
                        minWidth: 20,
                        height: 10,
                        splashColor: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () async {
                          print("SignOut");
                          final SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          sharedPreferences.remove("token");
                          print("Removed Tocken");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInPage()));
                        },
                        child: Text("SignOut"),
                      ))),
            ],
            centerTitle: true,
            backgroundColor: Colors.white10,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[Colors.red, Colors.blue])),
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Colors.orange[200], Colors.pinkAccent]),
          ),
          child: ListView.builder(
              padding: EdgeInsets.all(20),
              controller: _scrollController,
              itemCount: null == _doctors ? 0 : _doctors.length,
              itemBuilder: (context, index) {
                Datum doctor = _doctors[index];
                _getMoreData();

                return Container(
                  height: 150,
                  alignment: Alignment.center,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: Colors.blue[50],
                    child: ListTile(
                        title: Text(doctor.firstName + "  " + doctor.lastName),
                        trailing: Icon(
                          Icons.radio_button_on,
                          color: Colors.green,
                        ),
                        subtitle: Text(doctor.email),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(doctor.avatar),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => Details(_doctors[index]),
                            ),
                          );
                        }),
                  ),
                );
              }),
        ),
      ),
    );
  }
}

class Details extends StatefulWidget {
  final Datum doctor;
  Details(this.doctor);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: profileView(context));
  }

  Widget profileView(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(30, 50, 30, 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 50,
                width: 50,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignInPage())),
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              Text(
                'DOCTOR DETAILS',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              Container(height: 24, width: 24)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
          child: Stack(
            children: <Widget>[
              CircleAvatar(
                radius: 120,
                backgroundImage: NetworkImage(widget.doctor.avatar),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.black87, Color.fromRGBO(142, 14, 0, 1)])),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                  child: Container(
                    height: 60,
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.doctor.firstName.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(width: 1.0, color: Colors.white70)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                  child: Container(
                    height: 60,
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.doctor.email,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(width: 1.0, color: Colors.white70)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                  child: Container(
                    height: 60,
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.doctor.lastName + " MEDICAL CARE HOSPITAL",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(width: 1.0, color: Colors.white70)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                  child: Container(
                    height: 60,
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.doctor.email,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(width: 1.0, color: Colors.white70)),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 4),
                    child: ListTile(
                      title: Row(
                        children: <Widget>[
                          Expanded(
                              child: RaisedButton(
                            child: Text("Click To live Chat"),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            color: Colors.green,
                            textColor: Colors.black,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatScreen()),
                              );
                            },
                          )),
                          Expanded(
                            child: RaisedButton(
                              child: Text("Click to Favorite "),
                              //
                              textColor: Colors.red,
                              splashColor: Colors.redAccent,
                              highlightColor: Colors.white,
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                              // color: onClick ? Colors.grey : Colors.blue,
                              color: Colors.yellow,
                              // disabledColor: Colors.yellowAccent,
                              elevation: 6.0,
                              onPressed: () async {
                                //Adds index of fav to DB
                              },
                            ),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
