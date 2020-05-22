
import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/Models/Instituition.dart';

class CreateInstituition extends StatefulWidget {
  @override
  _CreateInstituitionState createState() => _CreateInstituitionState();
}

class _CreateInstituitionState extends State<CreateInstituition> {

  File file;
  List<dynamic> fields;
  Instituition instituition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Create a new instituition"),
          RaisedButton(child: Text("Select a File"),onPressed:() async {
            file = await FilePicker.getFile(type:FileType.custom, allowedExtensions: ['csv',]);
            fields = await file.openRead().transform(utf8.decoder).transform(new CsvToListConverter()).toList();
            instituition = createInstituitionFromCsvList(fields);
            setState(() {

            });
          }),
          file!=null?Text("PATH = " + file.path ,style: TextStyle(color: Colors.white),):Container(),
          instituition!= null?Text(instituition.toMap().toString(),style: TextStyle(color: Colors.white)): Container(),

        ],
      ),
    );
  }
}



