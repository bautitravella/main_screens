import 'dart:io';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:equatable/equatable.dart';


class User extends Equatable{
  String nombre;
  String apellido;
  String fotoPerfilUrl;
  CachedNetworkImageProvider fotoPerfil;
  File fotoPerfilRaw;
  bool hasAcceptedTerms;

  String email;

  User();

  User.fromEmail(this.email);


  User.allParameters(this.nombre, this.apellido, this.fotoPerfilUrl, this.hasAcceptedTerms,);

  User.fromMap(Map<String, dynamic> data,String email) {
    String nombre = data['nombre'];
    String apellido = data['apellido'];
    String fotoPerfil = data['fotoPerfilUrl'];
    bool hasAcceptedTerms = data['hasAcceptedTerms'];
    this.email = email;
    this.nombre = nombre;
    this.apellido = apellido;
    this.fotoPerfilUrl = fotoPerfil;
    this.fotoPerfil = CachedNetworkImageProvider(fotoPerfilUrl);
    this.hasAcceptedTerms= hasAcceptedTerms;
  }

  bool isComplete() {
    if (nombre == null ||
        apellido == null ||
        fotoPerfilUrl == null ||
        hasAcceptedTerms == null) {
      return false;
    }
    return true;
  }

  Map<String,dynamic> toMap(){
    Map<String,dynamic> userMap = new Map();
    userMap['nombre'] = nombre;
    userMap['apellido'] = apellido;
    userMap['fotoPerfilUrl'] = fotoPerfilUrl;
    userMap['hasAcceptedTerms']= hasAcceptedTerms;
    return userMap;
  }

  List<String> getColegios(){
    return null;
  }

  List<String> getCursos(){
    return null;
  }



  @override
  List<Object> get props => [nombre,apellido,fotoPerfilUrl,hasAcceptedTerms];

  @override
  String toString() {
    return 'User{nombre: $nombre, apellido: $apellido, fotoPerfilUrl: $fotoPerfilUrl, fotoPerfil: $fotoPerfil, hasAcceptedTerms: $hasAcceptedTerms, email: $email}';
  }


}
