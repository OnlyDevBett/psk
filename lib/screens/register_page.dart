import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'setup_profile.dart';

class RegisterPage extends StatefulWidget {
  final String email;

  const RegisterPage(this.email);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  void initState() {
    super.initState();
  }
  bool visible = false;

  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  final confirmPasswordController = new TextEditingController();

  Future _registerUser() async {
    setState(() {
      visible = true;
    });
    String email = emailController.text;
    String password = passwordController.text;

    var url = 'https://pasune.or.ke/Mobile_App_DB/register.php';
    var data = {'email': email, 'password': password};
    var response = await http.post(url, body: jsonEncode(data));
    var message = jsonDecode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        visible = false;
      });
      print(message);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', email);
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => SetUpProfile()));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green.shade500,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            CircleAvatar(
              child: new Image.network(
                  "https://pasune.or.ke/wp-content/uploads/2017/01/PASUNE-TRANSPARENT-1-e1592846444933.png"),
              maxRadius: 50,
              backgroundColor: Colors.transparent,
            ),
            SizedBox(
              height: 8.0,
            ),
            _buildRegisterForm(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                FloatingActionButton(
                  mini: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  backgroundColor: Colors.green.shade500,
                  child: Icon(Icons.arrow_back),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container _buildRegisterForm() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: RoundedDiagonalPathClipper(),
            child: Container(
              height: 380,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                color: Colors.white,
              ),
              child: Form(
                key: _form,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 90.0,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        controller: emailController,
                        validator: (val) {
                          if (val.isEmpty) return 'Enter Email!!!';
                          Pattern pattern =
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp regex = new RegExp(pattern);
                          if (!regex.hasMatch(val))
                            return 'Enter Valid Email';
                          else
                            return null;
                        },
                        style: TextStyle(color: Colors.green.shade500),
                        decoration: InputDecoration(
                          hintText: "Email address",
                          hintStyle: TextStyle(color: Colors.green.shade500),
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.email,
                            color: Colors.green.shade500,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Divider(
                        color: Colors.green.shade500,
                      ),
                      padding: EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 10.0),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        obscureText: true,
                        validator: (val) {
                          if (val.isEmpty) return 'Enter Password';
                          return null;
                        },
                        controller: passwordController,
                        style: TextStyle(color: Colors.green.shade500),
                        decoration: InputDecoration(
                          hintText: "Enter Password",
                          hintStyle: TextStyle(color: Colors.green.shade500),
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.lock,
                            color: Colors.green.shade500,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Divider(
                        color: Colors.green.shade500,
                      ),
                      padding: EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 10.0),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        obscureText: true,
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Re-Enter Password';
                          } else if (val != passwordController.text) {
                            return 'Password does not match';
                          }
                          return null;
                        },
                        controller: confirmPasswordController,
                        style: TextStyle(color: Colors.green.shade500),
                        decoration: InputDecoration(
                          hintText: "Confirm password",
                          hintStyle: TextStyle(color: Colors.green.shade500),
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.lock,
                            color: Colors.green.shade500,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Divider(
                        color: Colors.green.shade500,
                      ),
                      padding: EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 10.0),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 40.0,
                backgroundColor: Colors.green.shade100,
                child: Icon(Icons.person),
              ),
            ],
          ),
          Container(
            height: 400,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: RaisedButton(
                onPressed: () {
                  if (_form.currentState.validate() == true) {
                    _registerUser();
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0)),
                child: Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.white70),
                ),
                color: Colors.green.shade500,
              ),
            ),
          ),
          Center(
            child: Visibility(
              visible: visible,
              child: Container(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
