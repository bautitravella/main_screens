import 'dart:ui';

class User {
  String _nombre;
  String _apellido;
  String _fotoPerfilUrl;
  Image _fotoPerfil;
  bool _hasAcceptedTerms;
  String _rol;
  String _username;

  User();


  User.allParameters(this._nombre, this._apellido, this._fotoPerfilUrl, this._hasAcceptedTerms,
      this._rol, this._username);

  User.fromMap(Map<String, dynamic> data) {
    String nombre = data['nombre'];
    String apellido = data['apellido'];
    String fotoPerfil = data['foto de perfil'];
    bool hasAcceptedTerms = data['hasAcceptedTerms'];
    String rol = data['rol'];
    String username = data['username'];

    _nombre = nombre;
    _apellido = apellido;
    _fotoPerfilUrl = fotoPerfil;
    _hasAcceptedTerms= hasAcceptedTerms;
    _rol = rol;
    _username = username;
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
    if (_nombre == null ||
        _apellido == null ||
        _fotoPerfilUrl == null ||
        _hasAcceptedTerms == null ||
        _rol == null ||
        _username == null) {
      return false;
    }
    return true;
  }

  //Getters and Setters
  String get username => _username;

  set username(String value) {
    _username = value;
  }

  String get fotoPerfilUrl => _fotoPerfilUrl;

  set fotoPerfilUrl(String value) {
    _fotoPerfilUrl = value;
  }

  String get rol => _rol;

  set rol(String value) {
    _rol = value;
  }

  bool get hasAcceptedTerms => _hasAcceptedTerms;

  set hasAcceptedTerms(bool value) {
    _hasAcceptedTerms = value;
  }

  Image get fotoPerfil => _fotoPerfil;

  set fotoPerfil(Image value) {
    _fotoPerfil = value;
  }

  String get apellido => _apellido;

  set apellido(String value) {
    _apellido = value;
  }

  String get nombre => _nombre;

  set nombre(String value) {
    _nombre = value;
  }
}
