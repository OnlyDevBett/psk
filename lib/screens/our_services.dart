import 'package:flutter/material.dart';
import 'package:paralegal_society_of_kenya/widgets/our_services_row.dart';

class OurServices extends StatefulWidget {
  @override
  _OurServicesState createState() => _OurServicesState();
}

class _OurServicesState extends State<OurServices> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: Text("Our Services"),
      centerTitle: true,),
      body: new Container(
        color: Colors.green,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new Container(
              height: 650.0,
              width: double.infinity,
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.only(topLeft: const Radius.circular(30.0), topRight: const Radius.circular(30.0)),
                color: Colors.white,
              ),
              child: new DefaultTabController(
                length: 3,
                child: new Column(
                  children: <Widget>[
                    new OurServicesRow(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
