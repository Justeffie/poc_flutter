class Paciente {
  int _id;
  String _name;
  String _apellido;
  int _dni;
  int _fechaNacimiento;
  String _domicilio;
  double _peso;
  double _altura;
  List _enfermedadesPreexistentes;
  List _enfermedadesAntecedentesFamiliares;

  Paciente(this._id, this._name, this._apellido, this._dni, this._domicilio);

  Paciente.fromDB(this._id, this._name, this._apellido, this._dni,
      this._domicilio, this._peso, this._altura, this._fechaNacimiento);

  Paciente.test(this._name, this._apellido, this._dni, this._domicilio,
      this._peso, this._altura,
      [this._id]);

  Paciente.paraGuardar(this._name, this._apellido, this._dni, this._domicilio,
      this._peso, this._altura, this._fechaNacimiento);

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

  int get fechaNacimiento => _fechaNacimiento;

  int get dni => _dni;

  String get apellido => _apellido;

  String get name => _name;

  int get id => _id;

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'name': _name,
      'apellido': _apellido,
      'dni': _dni,
      'domicilio': _domicilio,
      'peso': _peso,
      'altura': _altura,
      'fechaNacimiento': _fechaNacimiento
    };
  }

  @override
  String toString() {
    return 'Paciente{_id: $_id,'
        ' _name: $_name,'
        ' _apellido: $_apellido,'
        ' _dni: $_dni,'
        ' _domicilio: $_domicilio, '
        '_peso: $_peso,'
        ' _altura: $_altura,'
        ' fechaNacimiento: $_fechaNacimiento}';
  }
}
