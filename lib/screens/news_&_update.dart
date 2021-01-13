import 'package:flutter/material.dart';
class NewsAndUpdate extends StatefulWidget {
  @override
  _NewsAndUpdateState createState() => _NewsAndUpdateState();
}

class _NewsAndUpdateState extends State<NewsAndUpdate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('News and Updates'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
    );
  }
}
