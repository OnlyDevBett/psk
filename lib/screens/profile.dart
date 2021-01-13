import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

bool _status = false;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final String mBio = "";

  final myController = TextEditingController();

  textListener() {
    print("Current Text is ${myController.text}");
  }

  @override
  void dispose() {
    super.dispose();
    myController.dispose();
  }

  @override
  void initState() {
    super.initState();
    getData();
    myController.addListener(textListener);
  }
  //variables declaration
  List list;
  String email,
      userName,
      photoUrl,
      phoneNumber,
      county,
      physicalAddress,
      subCounty,
      educationLevel,
      bio,
      paralegalSpecialization,
      orgAttachedTo;

  Future<List> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String mail = prefs.getString('email');
    var url = 'https://pasune.or.ke/Mobile_App_DB/viewProfile.php';
    var data = {'email': mail};
    var res = await http.post(url, body: jsonEncode(data));
    list = jsonDecode(res.body);
    final response = await http.get(url);
    setState(() {
      email = list[0]['name'];
      userName = list[0]['name'];
      photoUrl =
          'https://pasune.or.ke/Mobile_App_DB/uploads/${list[0]['image']}';
      phoneNumber = list[0]['phone_Number'];
      county = list[0]['county'];
      physicalAddress = list[0]['postal_Address'];
      subCounty = list[0]['sub_County'];
      educationLevel = list[0]['levelOfEducation'];
      bio = list[0]['Bio'];
      paralegalSpecialization = list[0]['paralegalSpecialization'];
      orgAttachedTo = list[0]['name'];
    });
    return json.decode(response.body);
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: new AppBar(title: Text("My Profile"),
      centerTitle: true,
    ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? SingleChildScrollView(
                  child: Stack(
                    children: <Widget>[
                      SizedBox(
                        height: 230,
                        width: double.infinity,
                        child: Image(
                          fit: BoxFit.fitWidth,
                          image: NetworkImage(
                              "https://pasune.or.ke/Mobile_App_DB/uploads/${list[0]['image']}"),
                        ),
                      ),
                      Positioned(
                        left: 400,
                        top: 180,
                        child: GestureDetector(
                          child: new CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 20.0,
                            child: new Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 24.0,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _status = true;
                            });
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(16.0, 180.0, 16.0, 16.0),
                        child: Column(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(16.0),
                                  margin: EdgeInsets.only(top: 16.0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(left: 96.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              userName,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10.0),
                                    ],
                                  ),
                                ),

                                Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "https://pasune.or.ke/Mobile_App_DB/uploads/${list[0]['image']}"),
                                        fit: BoxFit.fill),
                                  ),
                                  margin: EdgeInsets.only(left: 16.0),
                                ),

                              ],
                            ),
                            SizedBox(height: 20.0),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  ListTile(
                                    title: Text("My Details"),
                                  ),
                                  Divider(),
                                  ListTile(
                                    title: Text("Email"),
                                    subtitle: Text(list[0]['email']),
                                    leading: Icon(Icons.email, color: Colors.green,),
                                  ),
                                  ListTile(
                                    title: Text("Phone"),
                                    subtitle: Text(phoneNumber),
                                    leading: Icon(Icons.phone, color: Colors.green,),
                                  ),
                                  ListTile(
                                    title: Text("Website"),
                                    subtitle: Text("https://pasune.or.ke"),
                                    leading: Icon(Icons.web, color: Colors.green,),
                                  ),
                                  ListTile(
                                    title: Text("Bio"),
                                    subtitle: TextFormField(
                                        initialValue: bio,
                                       // controller: c2,
                                      // onChanged: (String text) {
                                      //   s2 = text;
                                      // },
                                    enabled: _status,),
                                    leading: Icon(Icons.person, color: Colors.green,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 60, right: 60),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                      Visibility(
                                          visible: _status,
                                          child: RaisedButton(
                                            child: new Text("Save"),
                                            textColor: Colors.white,
                                            color: Colors.green,
                                            onPressed: () {
                                              setState(() {
                                                _status = false;
                                                FocusScope.of(context).requestFocus(new FocusNode());
                                              });
                                              updateProfile();
                                            },
                                            shape: new RoundedRectangleBorder(
                                                borderRadius: new BorderRadius.circular(20.0)),
                                          )
                                      ),
                                      Visibility(
                                          visible: _status,
                                          child: RaisedButton(
                                            child: new Text("Cancel"),
                                            textColor: Colors.white,
                                            color: Colors.red,
                                            onPressed: () {
                                              setState(() {
                                                _status = false;
                                                FocusScope.of(context).requestFocus(new FocusNode());
                                              });
                                            },
                                            shape: new RoundedRectangleBorder(
                                                borderRadius: new BorderRadius.circular(20.0)),
                                          )
                                      ),
                                    ],),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Center(child: new CircularProgressIndicator(backgroundColor: Colors.green,));
        },
      ),
    );
  }

  Future updateProfile() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');
    print(email);
    final uri = Uri.parse("https://pasune.or.ke/Mobile_App_DB/update_profile.php");
    var request = http.MultipartRequest('POST', uri);
    request.fields['email'] = email;
    request.fields['bio']= mBio;
    var response = await request.send();
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Profile Updated!!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else {
      print('Profile update failed');
    }
  }
}
