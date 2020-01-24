import 'User.dart';

class Alumno extends User{
  String _colegio;
  String _curso;

  Alumno(String nombre, String apellido, String fotoPerfil, bool hasAcceptedTerms, String rol, String username,this._colegio , this._curso) : super(nombre, apellido, fotoPerfil, hasAcceptedTerms, rol, username);

}