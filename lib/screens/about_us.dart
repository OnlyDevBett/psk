
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../utils/text_files.dart';
import '../widgets/header.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, titleText: 'About us'),
      body: ListView(
        padding: EdgeInsets.all(15.0),
        children: <Widget>[
          new CircleAvatar(
            radius: 50.0,
            backgroundColor: Colors.transparent,
            child: Image.asset('assets/images/log.png'),
          ),
          new SizedBox(
            height: 20.0,
          ),
          new Container(
            height: 500.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              shape: BoxShape.rectangle,
              color: Colors.green.shade200,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(3.0, 3.0),
                  blurRadius: 5.0,
                  spreadRadius: 6.0,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(18.0),
              child: Column(
                children: <Widget>[
                  new Text(
                    '   PASUNE stands for Paralegal Support Network. '
                    'This is a coalition of Civil Society Organizations undertaking '
                    'paralegal initiatives as a means of enhancing access to justice in Kenya.',
                    style: new TextStyle(color: Colors.black, fontSize: 20.0),
                    textAlign: TextAlign.justify,
                  ),
                  new SizedBox(height: 10.0),
                  new Divider(
                    height: 5.0,
                    color: Colors.black,
                  ),
                  new SizedBox(
                    height: 10.0,
                  ),
                  new Text(
                    'When was it formed and why?',
                    style: new TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 26.0),
                  ),
                  new SizedBox(height: 10.0),
                  Divider(
                    height: 5.0,
                    color: Colors.black,
                  ),
                  Center(
                    child: new Text(about, style: new TextStyle(color: Colors.black, fontSize: 20.0, letterSpacing: 1.0),textAlign: TextAlign.justify,),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
