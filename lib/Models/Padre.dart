import 'dart:io';
import 'User.dart';

class Padre extends User{

  List<Hijo> _hijos = [];
  String rol = "Padre";

  Padre():super();

  Padre.allParameters(String nombre, String apellido, String fotoPerfil, bool hasAcceptedTerms,this._hijos) : super.allParameters(nombre, apellido, fotoPerfil, hasAcceptedTerms);

  Padre.fromImage(File image):super(){
    super.fotoPerfilRaw = image;
  }

  Padre.fromEmail(String email): super.fromEmail(email);

  Padre.fromMap(Map<String, dynamic> data,String email): super.fromMap(data,email){
    List<Map<String,dynamic>> hijosMapList = data['nombre'];
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
   userMap['rol'] = rol;
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