import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/EventsModel.dart';
import '../models/NotesModel.dart';
import '../utils/ChannelTasks.dart';
import '../widgets/EventControl.dart';
import '../widgets/Notes.dart';
import '../widgets/Reminder.dart';
import '../widgets/UpcomingEvents.dart';
import 'home.dart';

class MySchedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => EventsModel()
          ),
          ChangeNotifierProvider(
              create: (context) => NotesModel()
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (context) => MyHomePage(),
            'reminder': (context) => MyHomePage(mode: 'Reminder')
          },
          theme: ThemeData(
            primarySwatch: Colors.green,
            fontFamily: 'QuickSand',
          ),
        )
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String mode;
  MyHomePage({Key key,this.mode = 'Normal'}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if(widget.mode == 'Reminder'){
        List<String> details = await ChannelTasks.getReminderData();
        Reminder.showReminder(context, details,Provider.of<EventsModel>(context,listen: false));
      }
      MethodChannel channel = MethodChannel('com.paralegal.pasune.support');
      channel.setMethodCallHandler((MethodCall call) async {
        if(call.method == 'showReminder(call)'){
          showReminder(call);
        }
      });
    });
  }

  void showReminder(MethodCall call){
    dynamic details =  call.arguments;
    Reminder.showReminder(context, [details["Id"],details["Text"],details["Date"],details["Time"],details["Silent"],details["Repeat"],details["Type"]],Provider.of<EventsModel>(context,listen: false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
    backgroundColor: Colors.green,
      appBar: AppBar(
        title: Text('My Schedule',
          style:  TextStyle(fontSize: 25, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => HomePage(),
          )),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 10, left: 10, bottom: 10),
            child: Text('Upcoming Events: ',
              style: TextStyle(fontSize: 20, color: Colors.white,),
              textAlign: TextAlign.left,
            ),
          ),
          Flexible(
            flex: 13,
            child: Row(
              children: <Widget>[
                UpcomingEvents(),
                Expanded(child: EventControl()),
              ],
            ),
          ),
          Flexible(
            flex: 7,
            child: Notes(),
          )
        ],
      ),
    );
  }
}

