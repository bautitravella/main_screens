import 'dart:io';
import 'dart:ui';

class User {
  String nombre;
  String apellido;
  String fotoPerfilUrl;
  File fotoPerfil;
  bool hasAcceptedTerms;
  String rol;

  String email;

  User();

  User.fromEmail(this.email);


  User.allParameters(this.nombre, this.apellido, this.fotoPerfilUrl, this.hasAcceptedTerms,
      this.rol);

  User.fromMap(Map<String, dynamic> data) {
    String nombre = data['nombre'];
    String apellido = data['apellido'];
    String fotoPerfil = data['foto de perfil'];
    bool hasAcceptedTerms = data['hasAcceptedTerms'];
    String rol = data['rol'];

    nombre = nombre;
    apellido = apellido;
    fotoPerfilUrl = fotoPerfil;
    hasAcceptedTerms= hasAcceptedTerms;
    rol = rol;
  }

  static User fromMapToUser(Map<String, dynamic> data) {
    String nombre = data['nombre'];
    String apellido = data['apellido'];
    String fotoPerfil = data['foto de perfil'];
    bool hasAcceptedTerms = data['hasAcceptedTerms'];
    String rol = data['rol'];


    User newUser =
        User.allParameters(nombre, apellido, fotoPerfil, hasAcceptedTerms, rol);
    if (newUser.isComplete()) {
      return newUser;
    }
    return null;
  }

  bool isComplete() {
    if (nombre == null ||
        apellido == null ||
        fotoPerfilUrl == null ||
        hasAcceptedTerms == null ||
        rol == null ) {
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
    userMap['rol']=rol;
    return userMap;
  }

}
