

import 'dart:io';

import 'package:flutterui/Models/User.dart';

class AlumnoUniversitario extends User{
  List<String> universidades,colegios;
  String role = "AlumnoUniversitario";

  AlumnoUniversitario():super();

  AlumnoUniversitario.allParameters(String nombre, String apellido, String fotoPerfil, bool hasAcceptedTerms,String email) : super.allParameters(nombre, apellido, fotoPerfil, hasAcceptedTerms,email);

  AlumnoUniversitario.fromImage(File image):super(){
    super.fotoPerfilRaw = image;
  }

  AlumnoUniversitario.fromEmail(String email): super.fromEmail(email);

  AlumnoUniversitario.fromMap(Map<String, dynamic> data,String email): super.fromMap(data,email){
    if(data['universidades'] != null)universidades = data['universidades'];
    if(data['colegios'] != null)colegios = data['colegios'];

  }

  Map<String,dynamic> toMap(){
    var userMap = super.toMap();
    userMap['rol'] = role;
    universidades == null?userMap['universidades'] = []:userMap['universidades'] = universidades;
    return userMap;
  }
  @override
  List<String> getColegios(){
    List<String> colegiosList  = [];
    _hijos.forEach((hijo)  {
      String colegio = hijo.colegio;
      if(!colegiosList.contains(colegio)){
        colegiosList.add(colegio);
      }
    });
    return colegiosList;
  }

  List<String> getCursos(){
    List<String> cursos = [];
    _hijos.forEach((hijo) => cursos.add(hijo.curso));
    return cursos;
  }

  List<String> getHijosNames(){
    List<String> nombres = [];
    _hijos.forEach((hijo) => nombres.add(hijo.nombre));
    return nombres;
  }

  removeHijo(int index){
    if(index < _hijos.length || index >= 0){
      _hijos.removeAt(index);
    }
  }

  @override
  String getRole(){
    return role;
  }

  @override
  Padre clone(){
    return Padre.allParameters(this.nombre, this.apellido, this.fotoPerfilUrl, this.hasAcceptedTerms, this.email,this._hijos);
  }

  @override
  Alumno changeRole(){
    return Alumno.allParameters(this.nombre, this.apellido, this.fotoPerfilUrl, this.hasAcceptedTerms,this.email ,this._hijos.first.colegio, this._hijos.first.curso);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          super == other &&
              other is Padre &&
              runtimeType == other.runtimeType &&
              _hijos == other._hijos &&
              role == other.role;

  @override
  int get hashCode =>
      super.hashCode ^
      _hijos.hashCode ^
      role.hashCode;



}