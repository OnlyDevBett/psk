
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../database/DBQueries.dart';
import '../widgets/NotesCarousel.dart';

class NotesModel with ChangeNotifier{
  Widget notes;
  bool isLoading = true;

  NotesModel(){
    getData();
  }
  void getData() async {
    List<List<String>> data;
    isLoading = true;
    data = await DBQueries.getNotes();
    isLoading = false;
    (data.length == 0) ? notes = Expanded(
      child: Container(
        alignment: Alignment.center,
        child: Text('You haven\'t written any!',style: TextStyle(fontSize: 18, color: Colors.white54),textAlign: TextAlign.center,)
      ),
    )
    : notes = Expanded(child: NotesCarousel(input: data));
    notifyListeners();
  }

  void saveNote(String title,String text) async {
    await DBQueries.insertNote(title, text);
    getData();
  }

  void deleteNote(List<String> inp) async {
    await DBQueries.deleteNote(inp[0]);
    getData();
  }

  void editNote(String id, String title, String text) async {
    await DBQueries.editNotes(id, title, text);
    getData();
  }
}