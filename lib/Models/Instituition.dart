import 'package:flutter/cupertino.dart';

abstract class Instituition {
  String name, abreviation;
  int numberPeople, numberBooks;

  Instituition(
      this.name, this.abreviation, this.numberPeople, this.numberBooks);

  Instituition.fromMap(Map<String, dynamic> map) {
    if (map['abreviation'] != null) abreviation = map['abreviation'];
    if (map['name'] != null) name = map['name'];
    if (map['numberPeople'] != null) numberPeople = map['numberPeople'];
    if (map['numberBooks'] != null) numberBooks = map['numberBooks'];
  }
}

class School extends Instituition {
  List<String> years, subjects;

  School(this.years, this.subjects, String name, String abreviation,
      int numberPeople, int numberBooks)
      : super(name, abreviation, numberPeople, numberBooks);

  School.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
    if (map['years'] != null) years = map['years'];
    if (map['subjects'] != null) subjects = map['subjects'];
  }
}

class College extends Instituition {
  List<String> careers, years;

  College(this.careers, this.years, String name, String abreviation,
      int numberPeople, int numberBooks)
      : super(name, abreviation, numberPeople, numberBooks);

  College.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
    if (map['careers'] != null) careers = map['careers'];
    if (map['years'] != null) years = map['years'];
  }
}

Instituition createInstituitionFromMap(Map<String,dynamic> map){
  if(map != null && map['type'] !=null){
   return map['type'] == 'school'? School.fromMap(map):College.fromMap(map);
  }
  return null;
}
