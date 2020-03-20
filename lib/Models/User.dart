import 'dart:io';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterui/Models/Alumno.dart';
import 'package:flutterui/Models/Padre.dart';



class User extends Equatable{
  String nombre;
  String apellido;
  String fotoPerfilUrl,thumbFotoUrl;
  CachedNetworkImageProvider _fotoPerfil,_thumbFotoPerfil;
  File fotoPerfilRaw;
  bool hasAcceptedTerms;
  String email;

  User();

  User.fromEmail(this.email);


  User.allParameters(this.nombre, this.apellido, this.fotoPerfilUrl, this.hasAcceptedTerms,){
    this._fotoPerfil = CachedNetworkImageProvider(fotoPerfilUrl);
  }

  User.fromMap(Map<String, dynamic> data,String email) {
    String nombre = data['nombre'];
    String apellido = data['apellido'];
    String fotoPerfilUrl = data['fotoPerfilUrl'];
    String thumbFotoPerfilUrl = data['thumbFotoPerfilUrl'];
    bool hasAcceptedTerms = data['hasAcceptedTerms'];
    this.email = email;
    this.nombre = nombre;
    this.apellido = apellido;
    this.fotoPerfilUrl = fotoPerfilUrl;
    if(thumbFotoPerfilUrl != null)this.thumbFotoUrl = thumbFotoPerfilUrl;
    //this._fotoPerfil = CachedNetworkImageProvider(this.fotoPerfilUrl);
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

  String getRole(){
    return null;
  }

  User clone(){
    return User.allParameters(this.nombre, this.apellido, this.fotoPerfilUrl, this.hasAcceptedTerms);
  }

  User changeRole(){
    return null;
  }

  @override
  List<Object> get props => [nombre,apellido,fotoPerfilUrl,hasAcceptedTerms];

  @override
  String toString() {
    return 'User{nombre: $nombre, apellido: $apellido, fotoPerfilUrl: $fotoPerfilUrl, fotoPerfil: $_fotoPerfil, hasAcceptedTerms: $hasAcceptedTerms, email: $email}';
  }

  ImageProvider getProfileImage(){
    if(thumbFotoUrl != null){
      if(thumbFotoUrl == null){
        _thumbFotoPerfil = CachedNetworkImageProvider(thumbFotoUrl);
      }
      return _thumbFotoPerfil;
    }else if(fotoPerfilUrl != null){
      if(_fotoPerfil == null){
        _fotoPerfil = CachedNetworkImageProvider(fotoPerfilUrl);
      }
      return _fotoPerfil;
    }
    return AssetImage("assets/images/icons-back-light-2.png",);
  }

}

User createUserFromDocumentSnapshot(DocumentSnapshot documentSnapshot){
  assert(documentSnapshot!= null );
  assert(documentSnapshot.data != null);
  assert(documentSnapshot.data['rol'] != null);
  if(documentSnapshot.data['rol'] == 'Padre'){
    return new Padre.fromMap(documentSnapshot.data,documentSnapshot.documentID);
  }else{
    return Alumno.fromMap(documentSnapshot.data,documentSnapshot.documentID);
  }
}
