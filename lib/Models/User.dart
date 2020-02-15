import 'dart:io';
import 'dart:ui';

class User {
  String nombre;
  String apellido;
  String fotoPerfilUrl;
  File fotoPerfil;
  bool hasAcceptedTerms;

  String email;

  User();

  User.fromEmail(this.email);


  User.allParameters(this.nombre, this.apellido, this.fotoPerfilUrl, this.hasAcceptedTerms,);

  User.fromMap(Map<String, dynamic> data) {
    String nombre = data['nombre'];
    String apellido = data['apellido'];
    String fotoPerfil = data['foto de perfil'];
    bool hasAcceptedTerms = data['hasAcceptedTerms'];

    nombre = nombre;
    apellido = apellido;
    fotoPerfilUrl = fotoPerfil;
    hasAcceptedTerms= hasAcceptedTerms;
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
    userMap['apelido'] = apellido;
    userMap['fotoPerfilUrl'] = fotoPerfilUrl;
    userMap['hasAcceptedTerms']= hasAcceptedTerms;
    return userMap;
  }

}
