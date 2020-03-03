

import 'package:cloud_firestore/cloud_firestore.dart';

class ColegiosData{
  List<String> colegios = [];
  List<String> cursos = [];
  List<String> materias = [];

  ColegiosData.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){
    try{
      colegios = dynamicListToStringList(documentSnapshot['colegios']);
      cursos = dynamicListToStringList(documentSnapshot['cursos']);
      materias = dynamicListToStringList(documentSnapshot['materias']);
    }catch (e){
      print("ERROR INTENTADO CREAR COLEGIOS DATA");
    }
  }

  List<String> dynamicListToStringList(List<dynamic> list){
    List<String> stringsList = [];
    for(dynamic element in list){
      stringsList.add(element.toString());
    }
    return stringsList;
  }

}