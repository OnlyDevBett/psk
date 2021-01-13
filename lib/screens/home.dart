import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:paralegal_society_of_kenya/screens/our_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/greetings.dart';
import '../widgets/header.dart';
import '../widgets/oval_right_border_clipper.dart';
import 'faqs.dart';
import 'login_page.dart';
import 'my_schedules.dart';
import 'news_&_update.dart';
import 'our_partners.dart';
import 'paralegal_database.dart';
import 'profile.dart';
import 'resources.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  List list;
  String userName = "";
  String photoUrl = "";
  String role = "";
  bool isAdmin = false;
  String url;
  var green =Colors.green;
  var greenAccent = Colors.greenAccent;


  Future<List> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String mail = prefs.getString('email');
    var url = 'https://pasune.or.ke/Mobile_App_DB/viewProfile.php';
    var data = {'email': mail};
    var res = await http.post(url, body: jsonEncode(data));
    setState(() {
      list = jsonDecode(res.body);
      userName = list[0]['name'];
      role = list[0]['role'];
      photoUrl =
          "https://pasune.or.ke/Mobile_App_DB/uploads/${list[0]['image']}";
    });
    prefs.setString('role', role);
    print(list[0]['image']);
    final response = await http.get(url);
    return json.decode(response.body);
  }
  DateTime currentBackPressTime;

  PageController pageController;
  int pageIndex = 0;

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    getPrefs();
    pageController = PageController();
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

  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: header(context, titleText: 'Paralegal Society of Kenya'),
        drawer: ClipPath(
          clipper: OvalRightBorderClipper(),
          child: Drawer(
            child: new ListView(
              children: <Widget>[
                DrawerHeader(
                  child: Container(
                    width: 15.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.green,
                    ),
                    child: Center(
                      child: CircleAvatar(
                        child: new Image.network(
                            "https://pasune.or.ke/wp-content/uploads/2017/01/PASUNE-TRANSPARENT-1-e1592846444933.png"),
                        maxRadius: 60,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    'My Schedule',
                    style: TextStyle(color: Colors.black),
                  ),
                  leading: Icon(
                    Icons.schedule,
                    color: Colors.green,
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => MySchedule(),
                    ),
                  ),
                ),
                Divider(
                  thickness: 1.0,
                  color: Colors.grey,
                ),
                ListTile(
                  title: Text('News & Updates'),
                  leading: Icon(
                    Icons.today,
                    color: Colors.green,
                  ),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => NewsAndUpdate())),
                ),
                Divider(
                  thickness: 1.0,
                  color: Colors.grey,
                ),
                ListTile(
                  title: Text('Services'),
                  leading: Icon(
                    Icons.book,
                    color: Colors.green,
                  ),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => OurServices())),
                ),
                Divider(
                  thickness: 1.0,
                  color: Colors.grey,
                ),
                ListTile(
                    title: Text('My Profile'),
                    leading: Icon(
                      Icons.person,
                      color: Colors.green,
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => Profile(),
                        ),
                      );
                    }),
                Divider(
                  thickness: 1.0,
                  color: Colors.grey,
                ),
                ListTile(
                    title: Text('Logout'),
                    leading: Icon(
                      Icons.exit_to_app,
                      color: Colors.green,
                    ),
                    onTap: () {
                      logOutUser();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => LoginPage(),
                        ),
                      );
                    }),
                Divider(
                  thickness: 1.0,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
        body: PageView(
          children: <Widget>[
            new Stack(
              children: <Widget>[
                new Container(
                  height: 260.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment(1.0, 0.8),
                       colors: [green, greenAccent],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(140, 110),
                      bottomRight: Radius.elliptical(140, 110),
                    ),
                  ),
                  child: new ListView(
                    children: <Widget>[
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: new Container(
                              height: 50.0,
                              width: 190.0,
                              child: ListTile(
                                title: Text(
                                  greeting(),
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 23.0),
                                ),
                                subtitle: Text(
                                  userName ?? "User",
                                  style: new TextStyle(
                                      color: Colors.white,
                                      fontSize: 24.9,
                                      fontWeight: FontWeight.bold),
                                )
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                new Container(
                  margin: EdgeInsets.only(left: 20.0, top: 100.0, right: 20.0),
                  height: 200.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Material(
                    elevation: 3.0,
                    shadowColor: Colors.green,
                    borderRadius: BorderRadius.circular(10.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Material(
                                  elevation: 1.0,
                                  borderRadius: BorderRadius.circular(50.0),
                                  shadowColor: Colors.green,
                                  child: GestureDetector(
                                    onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                ResourcesPage())),
                                    child: ListTile(
                                      title: new Container(
                                        height: 50.0,
                                        width: 50.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(image: AssetImage("assets/images/icons/resources.png"),)
                                        ),
                                      ),
                                      subtitle: new Text(
                                        'Resources',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.0,),
                              Expanded(
                                child: Material(
                                  elevation: 1.0,
                                  borderRadius: BorderRadius.circular(50.0),
                                  shadowColor: Colors.green,
                                  child: GestureDetector(
                                    onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                FaQs())),
                                    child: ListTile(
                                      title: new Container(
                                        height: 50.0,
                                        width: 50.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(image: AssetImage("assets/images/icons/faqs.png"),)
                                        ),

                                      ),
                                      subtitle: new Text(
                                        'FAQs',
                                        textAlign: TextAlign.center,
                                        style: new TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          new SizedBox(
                            height: 18.0,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Material(
                                  elevation: 1.0,
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: GestureDetector(
                                    onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                OurPartners())),
                                    child: ListTile(
                                      title: new Container(
                                        height: 50.0,
                                        width: 50.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(image: AssetImage("assets/images/icons/partners.jpg"),)
                                        ),
                                       
                                      ),
                                      subtitle: new Text(
                                        'Our Partners',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                             SizedBox(width: 20.0,),
                              Expanded(
                                child: Material(
                                  elevation: 1.0,
                                  borderRadius: BorderRadius.circular(20.0),
                                  shadowColor: Colors.green,
                                  child: GestureDetector(
                                    onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                ParalegalDatabase())),
                                    child: ListTile(
                                      title: new Container(
                                        height: 50.0,
                                        width: 50.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            fit: BoxFit.contain,
                                              image: AssetImage("assets/images/icons/paralegal.jpg"),
                                          )
                                        ),

                                      ),
                                      subtitle: new Text(
                                        'Paralegal Database',
                                        textAlign: TextAlign.center,
                                        style: new TextStyle(color: Colors.black),
                                      ),
                                    ),
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
                new Container(
                  margin: EdgeInsets.only(left: 20.0, top: 330.0, right: 20.0),
                  height: 280.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      elevation: 2.0,
                      shadowColor: Colors.green,
                      borderRadius: BorderRadius.circular(10.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new ListView(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Connect with us on:",
                                textDirection: TextDirection.ltr,
                                style: TextStyle(fontSize: 22.0),
                              ),
                            ),
                            new SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Material(
                                    elevation: 2.0,
                                    borderRadius: BorderRadius.circular(60.0),
                                    child: GestureDetector(
                                      onTap: (){
                                     setState(() {
                                      url = 'https://www.facebook.com/pages/category/Nonprofit-Organization/Paralegal-Support-Network-206701856564500/';
                                     });
                                     _launchInBrowser(url);
                                      },
                                      onLongPress: (){
                                       isAdmin ? showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10.0)
                                                ),
                                                child: AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(32.0))),
                                                  title: Text("Update Facebook Link"),
                                                  content: TextField(
                                                    decoration: InputDecoration(hintText: "Paste the Url Here"),
                                                  ),
                                                  actions: <Widget>[
                                                    new FlatButton(
                                                      child: new Text('UPDATE'),
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                    new FlatButton(
                                                      child: new Text('CANCEL'),
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }) : new Container();
                                      },
                                      child: ListTile(
                                        title: new Container(
                                          height: 50.0,
                                          width: 50.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.pink,
                                          ),
                                          child: new CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 18.0,
                                            child: Image.asset(
                                                'assets/images/icons/facebook.png'),
                                          ),
                                        ),
                                        subtitle: new Text(
                                          'Facebook',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5.0,),
                                Expanded(
                                  child: Material(
                                    elevation: 2.0,
                                    borderRadius: BorderRadius.circular(60.0),
                                    child: GestureDetector(
                                      onLongPress: (){
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10.0)
                                                ),
                                                child: AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(32.0))),
                                                  title: Text("Update Instagram Link"),
                                                  content: TextField(
                                                    decoration: InputDecoration(hintText: "Paste the Url Here"),
                                                  ),
                                                  actions: <Widget>[
                                                    new FlatButton(
                                                      child: new Text('UPDATE'),
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                    new FlatButton(
                                                      child: new Text('CANCEL'),
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              );
                                            });
                                      },
                                      child: ListTile(
                                        title: new Container(
                                          height: 50.0,
                                          width: 50.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.pink,
                                          ),
                                          child: new CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 18.0,
                                              child: Image.asset(
                                                  'assets/images/icons/instagram.png')),
                                        ),
                                        subtitle: new Text(
                                          'Instagram',
                                          textAlign: TextAlign.center,
                                          style: new TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5.0,),
                                Expanded(
                                  flex: 1,
                                  child: Material(
                                    elevation: 2.0,
                                    borderRadius: BorderRadius.circular(60.0),
                                    child: GestureDetector(
                                      onLongPress: (){
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10.0)
                                                ),
                                                child: AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(32.0))),
                                                  title: Text("Update Skype Link"),
                                                  content: TextField(
                                                    decoration: InputDecoration(hintText: "Paste the Url Here"),
                                                  ),
                                                  actions: <Widget>[
                                                    new FlatButton(
                                                      child: new Text('UPDATE'),
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                    new FlatButton(
                                                      child: new Text('CANCEL'),
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              );
                                            });
                                      },
                                      child: ListTile(
                                        title: new Container(
                                          height: 50.0,
                                          width: 50.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.pink,
                                          ),
                                          child: new CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 18.0,
                                              child: Image.asset(
                                                  'assets/images/icons/skype.png')),
                                        ),
                                        subtitle: new Text(
                                          'Skype',
                                          textAlign: TextAlign.center,
                                          style: new TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new SizedBox(
                              height: 18.0,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Material(
                                    elevation: 2.0,
                                    borderRadius: BorderRadius.circular(60.0),
                                    child: GestureDetector(
                                      onLongPress: (){
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10.0)
                                                ),
                                                child: AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(32.0))),
                                                  title: Text("Update LinkedIn Link"),
                                                  content: TextField(
                                                    decoration: InputDecoration(hintText: "Paste the Url Here"),
                                                  ),
                                                  actions: <Widget>[
                                                    new FlatButton(
                                                      child: new Text('UPDATE'),
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                    new FlatButton(
                                                      child: new Text('CANCEL'),
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              );
                                            });
                                      },
                                      child: ListTile(
                                        title: new Container(
                                          height: 50.0,
                                          width: 50.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.pink,
                                          ),
                                          child: new CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 18.0,
                                              child: Image.asset(
                                                  'assets/images/icons/linkedin.png')),
                                        ),
                                        subtitle: new Text(
                                          'LinkedIn',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5.0,),
                                Expanded(
                                  child: Material(
                                    elevation: 2.0,
                                    borderRadius: BorderRadius.circular(60.0),
                                    child: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                           url = 'https://twitter.com/pasune_n?lang=en';
                                        });
                                        _launchInBrowser(url);
                                      },
                                      onLongPress: (){
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10.0)
                                                ),
                                                child: AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(32.0))),
                                                  title: Text("Update Twitter Link"),
                                                  content: TextField(
                                                    decoration: InputDecoration(hintText: "Paste the Url Here"),
                                                  ),
                                                  actions: <Widget>[
                                                    new FlatButton(
                                                      child: new Text('UPDATE'),
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                    new FlatButton(
                                                      child: new Text('CANCEL'),
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              );
                                            });
                                      },
                                      child: ListTile(
                                        title: new Container(
                                          height: 50.0,
                                          width: 50.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.pink,
                                          ),
                                          child: new CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 18.0,
                                              child: Image.asset(
                                                  'assets/images/icons/twitter.png')),
                                        ),
                                        subtitle: new Text(
                                          'Twitter',
                                          textAlign: TextAlign.center,
                                          style: new TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5.0,),
                                Expanded(
                                  child: Material(
                                    elevation: 2.0,
                                    borderRadius: BorderRadius.circular(60.0),
                                    child: GestureDetector(
                                      onLongPress: (){
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10.0)
                                                ),
                                                child: AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(32.0))),
                                                  title: Text("Update Whatsapp Link"),
                                                  content: TextField(
                                                    decoration: InputDecoration(hintText: "Paste the Url Here"),
                                                  ),
                                                  actions: <Widget>[
                                                    new FlatButton(
                                                      child: new Text('UPDATE'),
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                    new FlatButton(
                                                      child: new Text('CANCEL'),
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              );
                                            });
                                      },
                                      child: ListTile(
                                        title: new Container(
                                          height: 50.0,
                                          width: 50.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.pink,
                                          ),
                                          child: new CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 18.0,
                                              child: Image.asset(
                                                  'assets/images/icons/whatsapp.png')),
                                        ),
                                        subtitle: new Text(
                                          'Whatsapp',
                                          textAlign: TextAlign.center,
                                          style: new TextStyle(color: Colors.black),
                                        ),
                                      ),
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
                ),
              ],
            ),
            // ParalegalChat(),
            // Profile(),
          ],
          controller: pageController,
          onPageChanged: onPageChanged,
          physics: NeverScrollableScrollPhysics(),
        ),
      ),
    );
  }
  Widget usernameMethod() {
    return new FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  List list = snapshot.data;
                  return Card(
                    child: ListTile(
                      title: new Text("${list[0]['name']}"),
                      leading: new CircleAvatar(
                        child: Image.network(
                            "https://pasune.or.ke/Mobile_App_DB/uploads/${list[0]['image']}"),
                      ),
                      subtitle: new Text("${list[0]['phone_Number']}"),
                    ),
                  );
                },
              )
            : new Center();
      },
    );
  }

  Future logOutUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }


  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Press again to Exit");
      return Future.value(false);
    }
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return Future.value(true);
  }
}
Future<void> _launchInBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'cant launch the url';
  }
}