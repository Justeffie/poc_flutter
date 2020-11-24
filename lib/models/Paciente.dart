class Paciente {
  int _id;
  String _name;
  String _apellido;
  BigInt _dni;
  DateTime _fechaNacimiento;
  String _domicilio;
  double _peso;
  double _altura;
  List _enfermedadesPreexistentes;
  List _enfermedadesAntecedentesFamiliares;

  Paciente(this._name, this._apellido, this._dni, this._fechaNacimiento,
      this._domicilio);


  Paciente.conNombreYApellido(this._name, this._apellido);

  set enfermedadesAntecedentesFamiliares(List value) {
    _enfermedadesAntecedentesFamiliares = value;
  }

  set enfermedadesPreexistentes(List value) {
    _enfermedadesPreexistentes = value;
  }

  set altura(double value) {
    _altura = value;
  }

  set peso(double value) {
    _peso = value;
  }

  List get enfermedadesAntecedentesFamiliares =>
      _enfermedadesAntecedentesFamiliares;

  List get enfermedadesPreexistentes => _enfermedadesPreexistentes;

  double get altura => _altura;

  double get peso => _peso;

  String get domicilio => _domicilio;

  DateTime get fechaNacimiento => _fechaNacimiento;

  BigInt get dni => _dni;

  String get apellido => _apellido;

  String get name => _name;


}