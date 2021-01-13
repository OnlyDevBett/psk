import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/EventsModel.dart';
import '../models/NotesModel.dart';
import 'ControlButton.dart';
import 'NotesInput.dart';
import 'ReminderInput.dart';

class EventControl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        //height: MediaQuery.of(context).size.height*(0.55),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          border: Border(
            bottom: BorderSide(
              color: Colors.white,
              width: 1.5,
            ),
            top: BorderSide(
              color: Colors.white,
              width: 1.5,
            ),
            left: BorderSide(
              color: Colors.white,
              width: 1.5,
            ),
          ),
        ),
        child: Consumer2<EventsModel, NotesModel>(
          builder: (context, myEventsModel, myNotesModel, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                    child: ControlButton(
                  icon: Icons.add_alarm,
                  text: 'Add Reminder',
                  ontap: (BuildContext context) {
                    ReminderInput.reminderInput(
                        context, 'ring', myEventsModel.saveEvent);
                  },
                )),
                Expanded(
                    child: ControlButton(
                  icon: Icons.announcement,
                  text: 'Silent Reminder',
                  ontap: (BuildContext context) {
                    ReminderInput.reminderInput(
                        context, 'Silent', myEventsModel.saveEvent);
                  },
                )),
                Expanded(
                    child: ControlButton(
                  icon: Icons.history,
                  text: 'Repeating Reminder',
                  ontap: (BuildContext context) {
                    ReminderInput.reminderInput(
                        context, 'Repeating', myEventsModel.saveEvent);
                  },
                )),
                Expanded(
                    child: ControlButton(
                  icon: Icons.create,
                  text: 'Add New Note',
                  ontap: (BuildContext context) {
                    NotesInput.notesInput(context,
                        saveNote: myNotesModel.saveNote);
                  },
                )),
              ],
            );
          },
        ));
  }
}
