import 'User.dart';

class Padre extends User{

  List<Hijo> _hijos;

  Padre(String nombre, String apellido, String fotoPerfil, bool hasAcceptedTerms, String rol, String username,this._hijos) : super(nombre, apellido, fotoPerfil, hasAcceptedTerms, rol, username);


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


}

class Hijo{
  String _nombre,_colegio,_curso;

  Hijo(this._nombre, this._colegio, this._curso);


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Hijo &&
              runtimeType == other.runtimeType &&
              _nombre == other._nombre &&
              _colegio == other._colegio &&
              _curso == other._curso;

  @override
  int get hashCode =>
      _nombre.hashCode ^
      _colegio.hashCode ^
      _curso.hashCode;

  get curso => _curso;

  set curso(value) {
    _curso = value;
  }

  get colegio => _colegio;

  set colegio(value) {
    _colegio = value;
  }

  String get nombre => _nombre;

  set nombre(String value) {
    _nombre = value;
  }


}