import 'dart:core';
import 'dart:io';
import 'dart:ui';
import 'User.dart';

class Alumno extends User{
  String colegio;
  String curso;
  String rol = "Alumno";

  Alumno(): super();

  Alumno.allParameters(String nombre, String apellido, String fotoPerfil, bool hasAcceptedTerms,this.colegio , this.curso) : super.allParameters(nombre, apellido, fotoPerfil, hasAcceptedTerms);

  Alumno.fromMap(Map<String, dynamic> data,String email) : super.fromMap(data,email){
    colegio = data["colegio"];
    curso = data["curso"];
  }

  Alumno.fromImage(File image): super(){
    super.fotoPerfilRaw = image;
  }
  Alumno.fromEmail(String email): super.fromEmail(email);

  @override
  List<String> getColegios(){
    List<String> aux  = [colegio,];
    return aux;
  }

  @override
  List<String> getCursos(){
    List<String> aux = [curso,];
    return aux;
  }

  @override
  Map<String,dynamic > toMap() {
    Map<String,dynamic> userMap = super.toMap();
    userMap['colegio'] = colegio;
    userMap['curso'] = curso;
    userMap['rol'] = rol;
    return userMap;
  }

}