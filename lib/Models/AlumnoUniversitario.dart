

import 'dart:io';

import 'package:flutterui/Models/Alumno.dart';
import 'package:flutterui/Models/Padre.dart';
import 'package:flutterui/Models/User.dart';

class AlumnoUniversitario extends User{
  List<String> universidades,colegios;
  String role = "AlumnoUniversitario";

  AlumnoUniversitario():super();

  AlumnoUniversitario.allParameters(String nombre, String apellido, String fotoPerfil, bool hasAcceptedTerms,String email,this.universidades, this.colegios) : super.allParameters(nombre, apellido, fotoPerfil, hasAcceptedTerms,email);

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
    colegios == null?userMap['colegios'] =[]:userMap['colegios'] = colegios;
    return userMap;
  }
  @override
  List<String> getColegios(){
    List<String> colegiosList  = [];
    return colegiosList;
  }

  List<String> getActualInstitutions(){
    if(colegios == null || colegios.length ==0) {
      return universidades;
    }

    List<String> result = universidades;
    result.addAll(colegios);
    return result;
  }

  @override
  String getRole(){
    return role;
  }

  @override
  AlumnoUniversitario clone(){
    return AlumnoUniversitario.allParameters(this.nombre, this.apellido, this.fotoPerfilUrl, this.hasAcceptedTerms, this.email,this.universidades,this.colegios);
  }

  @override
  Alumno changeRoleToAlumno(){
    return Alumno.allParameters(this.nombre, this.apellido, this.fotoPerfilUrl, this.hasAcceptedTerms,this.email ,null, null);
  }

  @override
  Padre changeRoleToPadre(){
    return Padre.allParameters(this.nombre, this.apellido, this.fotoPerfilUrl, this.hasAcceptedTerms,this.email ,null);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          super == other &&
              other is AlumnoUniversitario &&
              runtimeType == other.runtimeType &&
              role == other.role;

  @override
  int get hashCode =>
      super.hashCode ^
      role.hashCode;

}