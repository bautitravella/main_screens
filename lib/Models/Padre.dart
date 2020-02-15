import 'dart:io';
import 'dart:ui';

import 'User.dart';

class Padre extends User{

  List<Hijo> _hijos;

  Padre():super();

  Padre.allParameters(String nombre, String apellido, String fotoPerfil, bool hasAcceptedTerms, String rol,this._hijos) : super.allParameters(nombre, apellido, fotoPerfil, hasAcceptedTerms, rol);

  Padre.fromImage(File image):super(){
    super.fotoPerfil = image;
  }

  Padre.fromEmail(String email): super.fromEmail(email);

  void agregarHijo(Hijo hijo){
    _hijos.add(hijo);
  }

  void sacarHijo(Hijo hijo){
    _hijos.remove(hijo);
  }

  List<Hijo> get hijos => _hijos;

  set hijos(List<Hijo> value) {
    _hijos = value;
  }

  Map<String,dynamic> toMap(){
   var userMap = super.toMap();
   List<Map> hijosMap = new List();
   _hijos.forEach((element) {hijosMap.add(element.toMap());});
   userMap['hijos'] = hijosMap;
   return userMap;
  }

  List<String> getColegios(){
    List<String> colegiosList  = [];
    _hijos.forEach((hijo) => colegiosList.add(hijo.colegio));
    return colegiosList;
  }

  List<String> getCursos(){
    List<String> cursos = [];
    _hijos.forEach((hijo) => cursos.add(hijo.curso));
    return cursos;
  }


}

class Hijo{
  String nombre,colegio,curso;

  Hijo(this.nombre, this.colegio, this.curso);


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Hijo &&
              runtimeType == other.runtimeType &&
              nombre == other.nombre &&
              colegio == other.colegio &&
              curso == other.curso;

  @override
  int get hashCode =>
      nombre.hashCode ^
      colegio.hashCode ^
      curso.hashCode;

  Map<String,dynamic> toMap(){
    return {"nombre": nombre, "colegio": colegio , "curso" : curso};
  }
}