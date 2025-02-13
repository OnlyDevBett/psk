import 'package:flutter/material.dart';

class NotesInput {
  static final _formKey = GlobalKey<FormState>();

  static void notesInput(BuildContext context,
      {Function saveNote,
      String initialtitle = ' ',
      String initialtext = ' ',
      String id = ' ',
      String type = 'new',
      Function editNote}) async {
    String title = initialtitle;
    String text = initialtext;
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Color.fromARGB(255, 23, 30, 39),
        title: Text(
          (type == 'new') ? 'Add new note ' : 'Edit note',
          style: TextStyle(
            fontSize: 22,
            color: Colors.green,
          ),
        ),
        content: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Title: ',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  TextFormField(
                    initialValue: title,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.0),
                        borderSide: BorderSide(color: Colors.white54),
                      ),
                      errorStyle: TextStyle(color: Colors.red),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.0),
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                    style: TextStyle(color: Colors.white),
                    onSaved: (value) => title = value,
                    validator: (value) =>
                        (value == ' ') ? 'This field must be filled' : null,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 5, top: 10, bottom: 5),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Body: ',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    width: MediaQuery.of(context).size.width,
                    height: (MediaQuery.of(context).size.height) * 0.2,
                    child: TextFormField(
                      initialValue: text,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.0),
                          borderSide: BorderSide(color: Colors.white54),
                        ),
                        errorStyle: TextStyle(color: Colors.red),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.0),
                            borderSide: BorderSide(color: Colors.white)),
                      ),
                      style: TextStyle(color: Colors.white),
                      maxLines: null,
                      minLines: null,
                      expands: true,
                      onSaved: (value) => text = value,
                      validator: (value) =>
                          (value == ' ') ? 'This field must be filled' : null,
                    ),
                  ),
                ],
              )),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Save Note',
                style: TextStyle(
                  color: Colors.green,
                )),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                if (type == 'new') {
                  saveNote(title, text);
                  Navigator.pop(context);
                } else if (type == 'edit') {
                  editNote(id, title, text);
                  int count = 0;
                  Navigator.popUntil(context, (route) {
                    return count++ == 2;
                  });
                }
              }
            },
          ),
          FlatButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: Text('Cancel',
                  style: TextStyle(
                    color: Colors.green,
                  ))),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
