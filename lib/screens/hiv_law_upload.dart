import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class HivAndLawUpload extends StatefulWidget {
  @override
  _HivAndLawUploadState createState() => _HivAndLawUploadState();
}

class _HivAndLawUploadState extends State<HivAndLawUpload> {
  File selectedfile, fileName;
  Response response;
  String progress;
  Dio dio = new Dio();

  selectFile() async {
    selectedfile = await FilePicker.getFile(
      type: FileType.custom,
      allowedExtensions: ['doc', 'pdf', 'docx'],
      //allowed extension to choose
    );
    setState((){}); //update the UI so that file name is shown
  }

  uploadFile() async {
    String uploadurl = "https://pasune.or.ke/Mobile_App_DB/hiv_and_law_upload.php";
    FormData formdata = FormData.fromMap({
      "file": await MultipartFile.fromFile(
          selectedfile.path,
          filename: (selectedfile.path)
        //show only filename from path
      ),
    });
    response = await dio.post(uploadurl,
      data: formdata,
      onSendProgress: (int sent, int total) {
        String percentage = (sent/total*100).toStringAsFixed(2);
        setState(() {
          progress = "$sent" + " Bytes of " "$total Bytes - " +  percentage + " % uploaded";
          //update the progress
        });
      },);
    if(response.statusCode == 200){
      print(response.toString());
      //print response from server
    }else{
      print("Error during connection to server.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:Text("Select File and Upload"),
        ), //set appbar
        body:Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(40),
            child:Column(children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                //show file name here
                child:progress == null?
                Text("Progress: 0%"):
                Text(("Progress: $progress"),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),),
                //show progress status here
              ),
              Container(
                margin: EdgeInsets.all(10),
                //show file name here
                child:selectedfile == null?
                Text("Choose File"):
                Text((selectedfile.path)),
                //basename is from path package, to get filename from path
                //check if file is selected, if yes then show file name
              ),
              Container(
                  child:RaisedButton.icon(
                    onPressed: (){
                      selectFile();
                    },
                    icon: Icon(Icons.folder_open),
                    label: Text("CHOOSE FILE"),
                    color: Colors.green,
                    colorBrightness: Brightness.dark,
                  )
              ),

              selectedfile == null ?
              Container():
              Container(
                  child:RaisedButton.icon(
                    onPressed: (){
                      uploadFile();
                    },
                    icon: Icon(Icons.folder_open),
                    label: Text("UPLOAD FILE"),
                    color: Colors.green,
                    colorBrightness: Brightness.dark,
                  )
              )
            ],)
        )
    );
  }

}
