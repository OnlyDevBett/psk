import 'dart:async';
import 'dart:convert';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Map list;

class ParalegalDatabase extends StatefulWidget {
  ParalegalDatabase() : super();

  @override
  _ParalegalDatabaseState createState() => _ParalegalDatabaseState();
}

class _ParalegalDatabaseState extends State<ParalegalDatabase> {

  List<String> selectedCountList = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paralegals"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[

          Expanded(
            child: FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);
                return snapshot.hasData
                    ? ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, int index) {
                    list = snapshot.data;

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: GestureDetector(
                          child: ListTile(
                            title: new Text("${list[index]["Name"]}"),
                            leading: Container(
                              width: 55.9,
                              height: 100.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(image: AssetImage(
                                      "assets/images/person.png"))
                              ),
                            ),
                            subtitle: Text(
                                "${list[index]["Paralegal Specialization"]}"),
                          ),
                          onTap: () {
                            _showInfo(context, "${list[index]["Name"]}",
                                "${list[index]["Email"]}",
                                "${list[index]["Phone Number"]}",
                                "${list[index]["Physical Address"]}",
                                "${list[index]["Paralegal Specialization"]}");
                          },
                        ),
                      ),
                    );
                  },
                )
                    : new Center(
                  child: new CircularProgressIndicator(
                    backgroundColor: Colors.green,),
                );
              },
            ),),


        ],
      ),
    );
  }
}

class FilterPage extends StatelessWidget {
  const FilterPage({Key key, this.allTextList}) : super(key: key);
  final List<String> allTextList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter list Page"),
      ),
      body: SafeArea(
        child: FilterListWidget(
          allTextList: allTextList,
          height: MediaQuery
              .of(context)
              .size
              .height,
          hideheaderText: true,
          onApplyButtonClick: (list) {
            Navigator.pop(context, list);
          },
        ),
      ),
    );
  }
}


void _showInfo(BuildContext context, String name, String email,
    String phoneNumber, String address, String specialization) {
  var alert = new AlertDialog(
    title: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Material(
            elevation: 2.0,
            shadowColor: Colors.green,
            borderRadius: BorderRadius.circular(10.0),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Name: " + name, style: TextStyle(fontSize: 19.0),),
            ),
          ),
          SizedBox(height: 15.0,),
          Material(
            elevation: 2.0,
            shadowColor: Colors.green,
            borderRadius: BorderRadius.circular(10.0),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Email: " + email, style: TextStyle(fontSize: 19.0),),
            ),
          ),
          SizedBox(height: 15.0,),
          Material(
            elevation: 2.0,
            shadowColor: Colors.green,
            borderRadius: BorderRadius.circular(10.0),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Contact: " + phoneNumber, style: TextStyle(fontSize: 19.0),),
            ),
          ),
          SizedBox(height: 15.0,),
          Material(
            elevation: 2.0,
            shadowColor: Colors.green,
            borderRadius: BorderRadius.circular(10.0),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Physical Address: " + address,
                style: TextStyle(fontSize: 19.0),),
            ),
          ),
          SizedBox(height: 15.0,),
          Material(
            elevation: 2.0,
            shadowColor: Colors.green,
            borderRadius: BorderRadius.circular(10.0),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Specialization: " + specialization,
                style: TextStyle(fontSize: 19.0),),
            ),
          ),
          SizedBox(height: 15.0,),
        ],
      ),
    ),

  );
  showDialog(context: context, child: alert);
}

// }
//
Future<Map> getData() async {
  var url = 'https://pasune.or.ke/Mobile_App_DB/paralegalsList.json';
  http.Response response = await http.get(url);
  List res = json.decode(response.body);
  return res.asMap();
}