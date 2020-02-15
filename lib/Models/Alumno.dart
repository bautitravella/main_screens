import 'dart:core';
import 'dart:io';
import 'dart:ui';
import 'User.dart';

class Alumno extends User{
  String _colegio;
  String _curso;

  Alumno(): super();

  Alumno.allParameters(String nombre, String apellido, String fotoPerfil, bool hasAcceptedTerms, String rol,this._colegio , this._curso) : super.allParameters(nombre, apellido, fotoPerfil, hasAcceptedTerms, rol);

  Alumno.fromMap(Map<String, dynamic> data) : super.fromMap(data){
    _colegio = data["colegio"];
    _curso = data["curso"];
  }

  Alumno.fromImage(File image): super(){
    super.fotoPerfil = image;
  }
  Alumno.fromEmail(String email): super.fromEmail(email);

  List<String> getColegios(){
    List<String> aux  = [_colegio,];
    return aux;
  }

  List<String> getCursos(){
    List<String> aux = [_curso,];
    return aux;
  }

  @override
  Map<String,dynamic > toMap() {
    Map<String,dynamic> userMap = super.toMap();
    userMap['colegio'] = _colegio;
    userMap['curso'] = _curso;
    return userMap;
  }

}