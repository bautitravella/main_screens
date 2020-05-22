import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/Models/Instituition.dart';
import 'package:flutterui/blocs/bloc.dart';

class CreateInstituition extends StatefulWidget {
  @override
  _CreateInstituitionState createState() => _CreateInstituitionState();
}

class _CreateInstituitionState extends State<CreateInstituition> {
  File file;
  List<dynamic> fields;
  Instituition instituition;
  Firestore _firestoreInstance = Firestore.instance;
  bool permissionToUpload = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Create a new instituition"),
          RaisedButton(
              child: Text("Select a File"),
              onPressed: () async {
                file = await FilePicker.getFile(
                    type: FileType.custom,
                    allowedExtensions: [
                      'csv',
                    ]);
                fields = await file
                    .openRead()
                    .transform(utf8.decoder)
                    .transform(new CsvToListConverter())
                    .toList();
                instituition = createInstituitionFromCsvList(fields);
                checkIfInstituitionAlreadyExists(instituition);
                setState(() {});
              }),
          file != null
              ? Text(
                  "PATH = " + file.path,
                  style: TextStyle(color: Colors.white),
                )
              : Container(),
          instituition != null
              ? Text(instituition.toMap().toString(),
                  style: TextStyle(color: Colors.white))
              : Container(),
          instituition != null
              ? permissionToUpload == true
                  ? RaisedButton(
                      onPressed: () => uploadInstituition(instituition),
                      child: Text("UPLOAD INSTITUITION"),
                    )
                  : Container(
                    child: Row(
                        children: [
                          Text(
                              "Ya hay una institucion cargada\n con ese nombre,\n estas seguro que deseas\n sobreescribirla??",
                            style: TextStyle(color: Colors.white),),
                          RaisedButton(
                            onPressed: () => updateInstituition(instituition),
                            child: Text("SOBREESCRIBIME PAPAAAA"),
                          )
                        ],
                      ),
                  )
              : Container(),
        ],
      ),
    );
  }

  void checkIfInstituitionAlreadyExists(Instituition instituition) async {
    final snapshot = await _firestoreInstance.document(instituition.name).get();
    if (snapshot == null || !snapshot.exists) {
      setState(() {
        permissionToUpload = true;
      });
    } else {
      setState(() {
        permissionToUpload = false;
      });
    }
  }

  void uploadInstituition(Instituition instituition) {
    _firestoreInstance.collection('Colegios').document(instituition.name).setData(instituition.toMap());
  }

  updateInstituition(Instituition instituition) {
    _firestoreInstance
        .collection('Colegios')
        .document(instituition.name)
        .setData(instituition.toMap());
  }
}
