import 'package:flutter/cupertino.dart';

abstract class Instituition {
  String name, abreviation;
  int numberPeople =0, numberBooks = 0;

  Instituition(
      this.name, this.abreviation, this.numberPeople, this.numberBooks);

  Instituition.fromMap(Map<String, dynamic> map) {
    if (map['abreviation'] != null) abreviation = map['abreviation'];
    if (map['name'] != null) name = map['name'];
    if (map['numberPeople'] != null) numberPeople = map['numberPeople'];
    if (map['numberBooks'] != null) numberBooks = map['numberBooks'];
  }

  Instituition.fromCsvList(List<List> list){
    for(int i = 1; i<list.length;i++) {
      if(list[i][0] == 'abreviation'){
        abreviation = list[i][1];
        abreviation.toUpperCase();
      }
    }
    for(int i = 1; i<list.length;i++) {
      if(list[i][0] == 'name'){
        name = list[i][1];
        name = titleCase(name);
      }
    }
    for(int i = 1; i<list.length;i++) {
      if(list[i][0] == 'numberPeople'){
        if(list[i][2] is num){
          numberPeople = list[i][2] as int;
        }else{
          numberPeople = int.parse(list[i][2]);
        }

      }
    }
    for(int i = 1; i<list.length;i++) {
      if(list[i][0] == 'numberBooks'){
        if(list[i][2] is num){
          numberBooks = list[i][2] as int;
        }else{
          numberBooks = int.parse(list[i][2]);
        }

      }
    }
  }



  Map<String,dynamic> toMap(){
    Map<String,dynamic> map = new Map();
    map['abreviation'] = abreviation;
    map['name'] = name;
    if(numberPeople!= null) map['numberPeople'] = numberPeople;
    if(numberBooks != null) map['numberBooks'] = numberBooks;
    return map;
  }

  @override
  String toString() {
    return 'Instituition{name: $name, abreviation: $abreviation, numberPeople: $numberPeople, numberBooks: $numberBooks';
  }


}

class School extends Instituition {
  List<String> years, subjects;
  String type = 'school';

  School(this.years, this.subjects, String name, String abreviation,
      int numberPeople, int numberBooks)
      : super(name, abreviation, numberPeople, numberBooks);

  School.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
    print('SCHOOL FROM MAP 1');
    if (map['years'] != null) {
      years = [];
      map['years'].forEach((element) => years.add(element));
    }
    if (map['subjects'] != null){
      subjects = [];
//      List<dynamic> aux = map['subjects'];
//      aux.forEach((element) {subjects.add(element);});
      map['subjects'].forEach((element) => subjects.add(element));

    }
    print('SCHOOL FROM MAP 2');
  }

  School.fromCsvList(List<List> list) : super.fromCsvList(list){
    for(int i = 1; i<list.length;i++) {
      if(list[i][0] == 'years'){
        years = [];
        for(int j =1;j<list[i].length;j++){
          years.add(list[i][j]);
        }
      }
    }
    String aux,aux2;
    for(int i = 1; i<list.length;i++) {
      if(list[i][0] == 'subjects'){
        subjects = [];
        for(int j =1;j<list[i].length;j++){
          aux = list[i][j].substring(1);
          aux2 = list[i][j].substring(0,1).toUpperCase();
          subjects.add(aux2 + aux);
        }
      }
    }
  }

  Map<String,dynamic> toMap(){
    Map<String,dynamic> map = super.toMap();
    map['years'] = years;
    map['subjects'] = subjects;
    map['type'] = type;
    return map;
  }

  @override
  String toString() {
    return super.toString() + 'years: $years, subjects: $subjects}';
  }
}

class College extends Instituition {
  List<String> careers, years;
  String type = "college";

  College(this.careers, this.years, String name, String abreviation,
      int numberPeople, int numberBooks)
      : super(name, abreviation, numberPeople, numberBooks);

  College.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
    if (map['careers'] != null){
      careers = [];
      map['careers'].forEach((element) => careers.add(element));
    }
    if (map['years'] != null) {
      years = [];
      map['years'].forEach((element) => years.add(element));
    }
  }

  College.fromCsvList(List<List> list):super.fromCsvList(list){
    String aux,aux2;
    for(int i = 1; i<list.length;i++) {
      if(list[i][0] == 'careers'){
        careers = [];
        for(int j =1;j<list[i].length;j++){
          aux = list[i][j].substring(1);
          aux2 = list[i][j].substring(0,1).toUpperCase();
          careers.add(list[i][j]);
        }
      }
    }
    for(int i = 1; i<list.length;i++) {
      if(list[i][0] == 'years'){
        years = [];
        for(int j =1;j<list[i].length;j++){
          years.add(list[i][j]);
        }
      }
    }
  }

  Map<String,dynamic> toMap(){
    Map<String,dynamic> map = super.toMap();
    map['years'] = years;
    map['careers'] = careers;
    map['type'] = type;
    return map;
  }

  @override
  String toString() {
    return super.toString() + ', $careers, years: $years}';
  }
}

Instituition createInstituitionFromMap(Map<String,dynamic> map){
  if(map != null && map['type'] !=null){
    print('CREATE INSTITUITION');
    return map['type'] == 'school'? School.fromMap(map):College.fromMap(map);
  }
  return null;
}

Instituition createInstituitionFromCsvList(List<List> list){
  if(list != null && list[0][0] is String){

    String firstString = list[0][0];
    if(firstString != null){
      return firstString == 'school'? School.fromCsvList(list):College.fromCsvList(list);
    }
  }
}

String titleCase(String text) {
  if (text.length <= 1) return text.toUpperCase();
  var words = text.split(' ');
  var capitalized = words.map((word) {
    var first = word.substring(0, 1).toUpperCase();
    var rest = word.substring(1);
    return '$first$rest';
  });
  return capitalized.join(' ');
}