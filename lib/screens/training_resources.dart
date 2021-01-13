import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_progress_dialog/flutter_progress_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:paralegal_society_of_kenya/widgets/pdf_from_url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'training_resources_upload.dart';

class TrainingResources extends StatefulWidget {
  @override
  _TrainingResourcesState createState() => _TrainingResourcesState();
}

class _TrainingResourcesState extends State<TrainingResources> {
  bool isAdmin = false;
  String fileUrl, fileName;

  @override
  void initState() {
    super.initState();
    getPrefs();
  }


  Future getPrefs() async {
    String role;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    role = prefs.getString('role');
    if (role == 'ADMIN') {
      setState(() {
        isAdmin = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.green,
          title: Text('Training Resources'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: () {})
          ],
        ),
        floatingActionButton: Visibility(
          visible: isAdmin ? true : false,
          child: FloatingActionButton(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      TrainingResourcesUpload()));
            },
          ),
        ),
        body: FutureBuilder(
          future: getFiles(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? RefreshIndicator(
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        List list = snapshot.data;
                        return Card(
                          child: isAdmin
                              ? Dismissible(
                                  key: ObjectKey(list[index]),
                                  child: GestureDetector(
                                    child: ListTile(
                                      title: new Text(
                                          "${list[index]['fileName']}"),
                                    ),
                                    onTap: () async {
                                      showProgressDialog();
                                      setState(() {
                                        fileName = "${list[index]['fileName']}";
                                        fileUrl =
                                            "https://pasune.or.ke/Mobile_App_DB/training_resources/${list[index]['fileName']}";
                                      });

                                      print(fileUrl);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute<dynamic>(
                                            builder: (_) => PDFViewerFromUrl(url: fileUrl, )
                                        ),
                                      );
                                    },
                                  ),
                                  onDismissed: (direction) {
                                    var item = "${list[index]['fileName']}";
                                    print(item);
                                  },
                                  background: slideRightBackground(),
                                  confirmDismiss: (direction) async {
                                    if (direction ==
                                        DismissDirection.endToStart) {
                                      final bool res = await showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              content: Text(
                                                  "Are you sure you want to delete ${list[index]['fileName']}?"),
                                              actions: <Widget>[
                                                FlatButton(
                                                  child: Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                FlatButton(
                                                  child: Text(
                                                    "Delete",
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                  onPressed: () {
                                                    _deleteFile(
                                                        "${list[index]['fileName']}");
                                                    setState(() {
                                                      list.removeAt(index);
                                                    });
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                      return res;
                                    } else {
                                      return null;
                                    }
                                  },
                                )
                              : GestureDetector(
                                  child: ListTile(
                                    title:
                                        new Text("${list[index]['fileName']}"),
                                  ),
                                  onTap: () async {
                                    showProgressDialog();
                                    setState(() {
                                      fileName = "${list[index]['fileName']}";
                                      fileUrl =
                                          "https://pasune.or.ke/Mobile_App_DB/training_resources/${list[index]['fileName']}";
                                    });
                                    print(fileUrl);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute<dynamic>(
                                          builder: (_) => PDFViewerFromUrl(url: fileUrl, )
                                      ),
                                    );
                                  },
                                ),
                        );
                      },
                    ),
                    onRefresh: _refetchData,
                  )
                : new Center(
                    child: new CircularProgressIndicator(),
                  );
          },
        ),
    );
  }

  Future<List> getFiles() async {
    var url = 'https://pasune.or.ke/Mobile_App_DB/training_resources.php';
    final response = await http.get(url);
    return json.decode(response.body);
  }

  Future<void> _refetchData() async {
    setState(() {
      getFiles();
    });
  }

  Widget slideRightBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  Future _deleteFile(String fileName) async {
    var url =
        'https://pasune.or.ke/Mobile_App_DB/delete_training_resources.php';
    var data = {
      'filename': fileName,
    };
    var response = await http.post(url, body: jsonEncode(data));
    var message = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(message);
      var s = message;
      if (s == "yes") {
        _refetchData();
        Fluttertoast.showToast(
            msg: "File Deleted!!!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("Error Message"),
              content: new Text(s ?? "Loading..."),
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
}
