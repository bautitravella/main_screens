
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CreateInstituition extends StatefulWidget {
  @override
  _CreateInstituitionState createState() => _CreateInstituitionState();
}

class _CreateInstituitionState extends State<CreateInstituition> {

  File file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Create a new instituition"),
          RaisedButton(child: Text("Select a File"),onPressed:() async => file = await FilePicker.getFile(),),
        ],
      ),
    );
  }
}



