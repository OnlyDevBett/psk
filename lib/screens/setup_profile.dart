import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/counties_list.dart';
import 'home.dart';

class SetUpProfile extends StatefulWidget {
  @override
  _SetUpProfileState createState() => _SetUpProfileState();
}

class _SetUpProfileState extends State<SetUpProfile> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final FocusNode myFocusNode = FocusNode();
  Future<File> file;
  String base64Image;
  File tmpFile;
  bool visible= false;
  final picker = ImagePicker();
  File _image;
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneNumberController = new TextEditingController();
  TextEditingController subCountyController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController bioInfoController = new TextEditingController();
  String fileName, selectedCounty, selectedGender;
  List<String> genderList = ["Male", "Female", "Other"];
  bool show = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text(
            "Profile",
          ),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: Form(
          key: _form,
          child: new Container(
            color: Colors.green.shade200,
            child: new ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    new Container(
                      height: 200.0,
                      color: Colors.white,
                      child: new Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: new Stack(
                              fit: StackFit.loose,
                              children: <Widget>[
                                new Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: 150,
                                      height: 150,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: _image == null  //profilePhoto which is File object
                                                  ? AssetImage(
                                                  "assets/images/profile.png")
                                                  : FileImage(_image), // picked file
                                              fit: BoxFit.fill)),
                                    ),

                                  ],
                                ),
                                GestureDetector(
                                  onTap: selectImage,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: 90.0, right: 100.0),
                                    child: new Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        new CircleAvatar(
                                          backgroundColor: Colors.green.shade500,
                                          radius: 25.0,
                                          child: new Icon(
                                            Icons.camera_alt,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    new Container(
                      color: Color(0xffFFFFFF),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 5.0),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0,),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Personal Information',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'Name',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextFormField(
                                      controller: nameController,
                                      validator: (val) {
                                        if (val.isEmpty) return 'Enter Name!!!';
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        hintText: "Enter Your Name",
                                      ),
                                      enabled: true,
                                      autofocus: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 15.0),
                              child: DropdownButtonFormField(
                                hint: Text("Gender"),
                                  items: genderList.map((gender) {
                                    return DropdownMenuItem(
                                      value: gender,
                                        child: Text(gender),);
                                  }).toList(),
                                  onChanged: (value){
                                    setState(() {
                                      selectedGender = value;
                                    });
                                  })
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Mobile',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new TextFormField(
                                        controller: phoneNumberController,
                                        validator: (val) {
                                          if (val.isEmpty)
                                            return 'Enter Phone Number!!!';
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                            hintText: "Enter Mobile Number"),
                                        enabled: true,
                                        keyboardType:
                                            TextInputType.numberWithOptions(),
                                      ),
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: new Text(
                                          'County',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      flex: 2,
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: new Text(
                                          'Sub County',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      flex: 2,
                                    ),
                                  ],
                                )),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: DropdownButton( // Not necessary for Option 1
                                        value: selectedCounty,
                                        hint: Text("Select County"),
                                        isExpanded: true,
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedCounty = newValue;
                                          });
                                        },
                                        items: counties.map((location) {
                                          return DropdownMenuItem(
                                            child: new Text(location),
                                            value: location,
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                  Flexible(
                                    child: new TextFormField(
                                      controller: subCountyController,
                                      validator: (val) {
                                        if (val.isEmpty)
                                          return 'Enter SubCounty!!!';
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                          hintText: "Your Sub County"),
                                      enabled: true,
                                      keyboardType: TextInputType.text,
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Physical Address',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextFormField(
                                      controller: addressController,
                                      validator: (val) {
                                        if (val.isEmpty)
                                          return 'Enter Physical Address!!!';
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                          hintText: "Enter Physical Address"),
                                      enabled: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Bio',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextFormField(
                                      controller: bioInfoController,
                                      validator: (val) {
                                        if (val.isEmpty) return 'Bio';
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                          hintText: "Brief info about Yourself"),
                                      enabled: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _getActionButtons(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future selectImage() async {
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      show = true;
      _image = File(pickedImage.path);
    });
  }
  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                child: new RaisedButton(
                  child: new Text("Save"),
                  textColor: Colors.white,
                  color: Colors.green,
                  onPressed: () {
                    if (_form.currentState.validate() == true) {
                      if (show == true) {
                        updateProfile();
                       Visibility(
                         visible: visible,
                           child: CircularProgressIndicator(semanticsLabel: 'Updating Profile',));
                      }
                      return 'Select Image';
                    }
                    return Container();
                  },
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Future updateProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');
    final uri = Uri.parse("https://pasune.or.ke/Mobile_App_DB/upload.php");
    var request = http.MultipartRequest('POST', uri);
    request.fields['email'] = email;
    request.fields['name'] = nameController.text;
    request.fields['phoneNumber'] = phoneNumberController.text;
    request.fields['county'] = selectedCounty;
    request.fields['subCounty'] = subCountyController.text;
    request.fields['postalAddress'] = addressController.text;
    request.fields['gender'] = selectedGender;
    request.fields['bio'] = bioInfoController.text;
    request.fields['role'] = 'NOT_ADMIN';
    var pic = await http.MultipartFile.fromPath("image", _image.path);
    request.files.add(pic);
    var response = await request.send();
    if (response.statusCode == 200) {
      print('Profile Updated');
      setState(() {
        visible = false;
      });
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => HomePage(),
        ),
      );
    } else {
      print('Profile update failed');
    }
  }

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Icon(Icons.error_outline, color: Colors.red,),
        content: new Text('Complete Your Profile Setup'),
        actions: <Widget>[
          Center(child: FlatButton(onPressed: () => Navigator.of(context).pop(false), child: Text("OK", style: TextStyle(fontSize: 20.0),)))
        ],
      ),
    );
  }
}
