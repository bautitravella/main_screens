import 'dart:io';
import 'package:flutterui/Models/Alumno.dart';

import 'User.dart';

class Padre extends User{

  List<Hijo> _hijos = [];
  String role = "Padre";

  Padre():super();

  Padre.allParameters(String nombre, String apellido, String fotoPerfil, bool hasAcceptedTerms,String email,this._hijos) : super.allParameters(nombre, apellido, fotoPerfil, hasAcceptedTerms,email);

  Padre.fromImage(File image):super(){
    super.fotoPerfilRaw = image;
  }

  Padre.fromEmail(String email): super.fromEmail(email);

  Padre.fromIndexMap(Map<String, dynamic> data): super.fromIndexMap(data){

  }

  Padre.fromMap(Map<String, dynamic> data,String email): super.fromMap(data,email){
    List<dynamic> hijosMapList = data['hijos'];
    hijosMapList.forEach((hijoMap) {_hijos.add(Hijo.fromMap(hijoMap)); });
  }

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
   userMap['rol'] = role;
   List<Map> hijosMap = new List();
   _hijos.forEach((element) {hijosMap.add(element.toMap());});
   userMap['hijos'] = hijosMap;
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

class Hijo{
  String nombre,colegio,curso;

  Hijo(this.nombre, this.colegio, this.curso);

  Hijo.fromMap(Map<String,dynamic> hijoMap){
    String colegio = hijoMap['colegio'];
    String curso = hijoMap['curso'];
    String nombre = hijoMap['nombre'];
    if(colegio != null && curso != null && nombre != null){
      this.colegio =colegio;
      this.curso = curso;
      this.nombre = nombre;
    }
  }

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