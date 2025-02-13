import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/NotesModel.dart';

class Notes extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        border: Border(top: BorderSide(width: 1.7, color: Colors.white)),
      ),  
      margin: EdgeInsets.only(top:10),
      padding: EdgeInsets.all(5),
      width: double.infinity,
     child: Column(
       mainAxisSize: MainAxisSize.max,
       mainAxisAlignment: MainAxisAlignment.start,
       children: <Widget>[
         Text('Notes: ',style: TextStyle(fontSize: 20, color: Colors.white,),textAlign: TextAlign.center,),
         Consumer<NotesModel>(
           builder: (context,myNotesModel,child){
             return myNotesModel.isLoading ? Expanded(
               child: Container(
                 alignment: Alignment.center,
                 child: Text('Please wait...',
                   style:  TextStyle(fontSize: 18, color: Colors.white54),
                   textAlign: TextAlign.center,
                 ),
               ),
             )
             :
             myNotesModel.notes;
           }
         ),
       ],
     ),
    );
  }
}
