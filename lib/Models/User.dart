import 'dart:io';
import 'dart:ui';

class User {
  String nombre;
  String apellido;
  String fotoPerfilUrl;
  File fotoPerfil;
  bool hasAcceptedTerms;
  String rol;
  String username;
  String email;

  User();

  User.fromEmail(this.email);


  User.allParameters(this.nombre, this.apellido, this.fotoPerfilUrl, this.hasAcceptedTerms,
      this.rol, this.username);

  User.fromMap(Map<String, dynamic> data) {
    String nombre = data['nombre'];
    String apellido = data['apellido'];
    String fotoPerfil = data['foto de perfil'];
    bool hasAcceptedTerms = data['hasAcceptedTerms'];
    String rol = data['rol'];
    String username = data['username'];

    nombre = nombre;
    apellido = apellido;
    fotoPerfilUrl = fotoPerfil;
    hasAcceptedTerms= hasAcceptedTerms;
    rol = rol;
    username = username;
  }

  static User fromMapToUser(Map<String, dynamic> data) {
    String nombre = data['nombre'];
    String apellido = data['apellido'];
    String fotoPerfil = data['foto de perfil'];
    bool hasAcceptedTerms = data['hasAcceptedTerms'];
    String rol = data['rol'];
    String username = data['username'];

    User newUser =
        User.allParameters(nombre, apellido, fotoPerfil, hasAcceptedTerms, rol, username);
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
        rol == null ||
        username == null) {
      return false;
    }
    return true;
  }

}
