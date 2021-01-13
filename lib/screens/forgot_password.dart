import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _selectedEmail = TextEditingController();
  bool visibilityStatus = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Reset Password'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 20, right: 20),
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.green)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _selectedEmail,
                    obscureText: false,
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
                    cursorColor: Colors.green,
                    style: TextStyle(color: Colors.green.shade500),
                    decoration: InputDecoration(
                      hintText: "Enter Email Address",
                      hintStyle: TextStyle(color: Colors.green.shade500),
                      icon: Icon(
                        Icons.email,
                        color: Colors.green.shade500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: FlatButton(
                  color: Colors.green,
                  onPressed: () {
                    _generateResetCode();
                    setState(() {
                      visibilityStatus = true;
                    });
                    // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>VerifyCode()));
                  },
                  child: Text(
                    "Reset Password",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ),
          Visibility(
            visible: visibilityStatus,
            child: Center(
              child: Loading(
                  indicator: BallPulseIndicator(),
                  size: 70.0,
                  color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }

  Future _generateResetCode() async {
    String email = _selectedEmail.text;
    var url = 'https://pasune.or.ke/Mobile_App_DB/resetpassword.php';
    var data = {
      'email': email,
    };
    var response = await http.post(url, body: jsonEncode(data));
    var message;
    if (response.body.isNotEmpty) {
      message = json.decode(response.body);
    }
    var res = "true";
    if (message == res) {
      print(email);
      print(message);
      setState(() {
        visibilityStatus = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Message"),
            content: new Text("Reset link has been sent to $email"),
            actions: <Widget>[
              new Center(
                child: new FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: new Text("Ok")),
              ),
            ],
          );
        },
      );
    }
  }
}
