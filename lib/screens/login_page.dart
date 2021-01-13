import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'forgot_password.dart';
import 'home.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  void initState() {
    super.initState();
  }
  bool visible = false;
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: new Container(
          color: Colors.green.shade500,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              CircleAvatar(
                child: new Image.network(
                  "https://pasune.or.ke/wp-content/uploads/2017/01/PASUNE-TRANSPARENT-1-e1592846444933.png",
                ),
                maxRadius: 50,
                backgroundColor: Colors.transparent,
              ),
              SizedBox(
                height: 8.0,
              ),
              _buildLoginForm(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  RegisterPage('')));
                    },
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => RegisterPage(''),
                          ),
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  Container _buildLoginForm() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: RoundedDiagonalPathClipper(),
            child: Container(
              height: 360,
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
                      height: 40.0,
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
                        style: TextStyle(
                          color: Colors.green.shade500,
                        ),
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
                      padding:
                      EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        validator: (val) {
                          if (val.isEmpty) return 'Enter Password!!!';
                          return null;
                        },
                        controller: passwordController,
                        obscureText: true,
                        style: TextStyle(color: Colors.green.shade500),
                        decoration: InputDecoration(
                          hintText: "Password",
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
                      padding:
                      EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ForgotPassword()));
                          },
                          child: Container(
                            padding: EdgeInsets.only(right: 20.0),
                            child: Text(
                              "Forgot Password",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
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
                backgroundColor: Colors.green.shade200,
                child: Icon(Icons.person),
              ),
            ],
          ),
          Container(
            height: 385,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: RaisedButton(
                onPressed: () {
                  if (_form.currentState.validate() == true) {
                    _login();
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0)),
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
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
          ),
        ],
      ),
    );
  }

  Future _login() async {
    setState(() {
      visible = true;
    });
    String email = emailController.text;
    String password = passwordController.text;
    var url = 'https://pasune.or.ke/Mobile_App_DB/login.php';
    var data = {'email': email, 'password': password};
    var response = await http.post(url, body: jsonEncode(data));
    var message = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        visible = false;
      });
      print(message);
      var s = message;
      if (s == 1) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', email);
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>HomePage()));
      }
      else{
        showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              title: new Text("Error Message"),
              content: new Text(s),
              actions: <Widget>[
                new Center(
                  child: new FlatButton(onPressed: ()=> Navigator.of(context).pop(), child: new Text("Ok")),
                ),
              ],
            );
          },
        );
      }
    }
  }

 
}
