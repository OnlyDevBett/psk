import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/EventsModel.dart';

class UpcomingEvents extends StatelessWidget{

  @override 
  Widget build(BuildContext context){
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 10, right: 10),
      width: MediaQuery.of(context).size.width*(0.75),
      decoration: BoxDecoration(
//        color: Color.fromARGB(150, 41, 43, 50),
        color: Colors.green[400],
        border: Border.all(width: 1, color: Colors.white),
      ),
      child:
        Consumer<EventsModel>(
          builder: (context,myEventsModel,child){
          return myEventsModel.isLoading ? Container(
            alignment: Alignment.center,
            child:  Text('Please wait...',
              style: TextStyle(fontSize: 18, color: Colors.white54),
              textAlign: TextAlign.center,
            )
          )
          : 
          myEventsModel.upcomingevents;
        },
      )
    );
  }  
}

