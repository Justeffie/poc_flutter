class Paciente {
  int _id;
  String _name;
  String _apellido;
  int _dni;
  int _fechaNacimiento;
  String _domicilio;
  double _peso;
  double _altura;
  List _enfermedadesPreexistentesEnum;
  List _enfermedadesAntecedentesFamiliaresEnum;
  String _enfermedadesPreexistentes;
  String _enfermedadesAntecedentesFamiliares;

  Paciente(this._id, this._name, this._apellido, this._dni, this._domicilio);

  Paciente.fromDB(
    this._id,
    this._name,
    this._apellido,
    this._dni,
    this._domicilio,
    this._peso,
    this._altura,
    this._fechaNacimiento,
    this._enfermedadesAntecedentesFamiliares,
    this._enfermedadesPreexistentes,
  );

  Paciente.fromHttp(
    this._id,
    this._name,
    this._apellido,
    this._dni,
    this._domicilio,
    this._peso,
    this._altura,
    this._fechaNacimiento,
    this._enfermedadesPreexistentesEnum,
    this._enfermedadesAntecedentesFamiliaresEnum,
  );

  factory Paciente.fromJson(Map<String, dynamic> json) {
    return Paciente.fromHttp(
      json['id'],
      json['name'],
      json['apellido'],
      json['dni'],
      json['domicilio'],
      json['peso'],
      json['altura'],
      json['fechaNacimiento'],
      json['enfermedadesPreexistentes'],
      json['enfermedadesAntecedentesFamiliares']
    );
  }

  Paciente.test(this._name, this._apellido, this._dni, this._domicilio,
      this._peso, this._altura,
      [this._id]);

  Paciente.paraGuardar(
    this._name,
    this._apellido,
    this._dni,
    this._domicilio,
    this._peso,
    this._altura,
    this._fechaNacimiento,
    this._enfermedadesAntecedentesFamiliares,
    this._enfermedadesPreexistentes,
  );

  Paciente.paraGuardarHttp(
    this._name,
    this._apellido,
    this._dni,
    this._domicilio,
    this._peso,
    this._altura,
    this._fechaNacimiento,
    this._enfermedadesAntecedentesFamiliaresEnum,
    this._enfermedadesPreexistentesEnum,
  );

  Paciente.conNombreYApellido(this._name, this._apellido);

  set enfermedadesAntecedentesFamiliares(String value) {
    _enfermedadesAntecedentesFamiliares = value;
  }

  set enfermedadesPreexistentes(String value) {
    _enfermedadesPreexistentes = value;
  }

  set altura(double value) {
    _altura = value;
  }

  set peso(double value) {
    _peso = value;
  }

  String get enfermedadesAntecedentesFamiliares =>
      _enfermedadesAntecedentesFamiliares;

  String get enfermedadesPreexistentes => _enfermedadesPreexistentes;


  List get enfermedadesPreexistentesEnum => _enfermedadesPreexistentesEnum;

  set enfermedadesPreexistentesEnum(List value) {
    _enfermedadesPreexistentesEnum = value;
  }

  List get enfermedadesAntecedentesFamiliaresEnum =>
      _enfermedadesAntecedentesFamiliaresEnum;

  set enfermedadesAntecedentesFamiliaresEnum(List value) {
    _enfermedadesAntecedentesFamiliaresEnum = value;
  }

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
      'fechaNacimiento': _fechaNacimiento,
      'antecedentesFamiliares': _enfermedadesAntecedentesFamiliaresEnum,
      'enfermedadesPreexistentes': _enfermedadesPreexistentesEnum
    };
  }

  @override
  String toString() {
    return 'Paciente{_id: $_id,'
        ' _name: $_name,'
        ' _apellido: $_apellido,'
        ' _dni: $_dni,'
        ' _domicilio: $_domicilio,'
        ' _peso: $_peso,'
        ' _altura: $_altura,'
        ' fechaNacimiento: $_fechaNacimiento},'
        ' antecedentesFamiliares: $_enfermedadesAntecedentesFamiliares, '
        ' enfermedadesPreexistentes: $_enfermedadesPreexistentes}';
  }

  String toJson() {
    return '{\"id\": $_id,'
        ' \"name\": \"$_name\",'
        ' \"apellido\": \"$_apellido\",'
        ' \"dni\": $_dni,'
        ' \"domicilio\": \"$_domicilio\",'
        ' \"peso\": $_peso,'
        ' \"altura\": $_altura,'
        ' \"fechaNacimiento\": $_fechaNacimiento,'
        ' \"enfermedadesAntecedentesFamiliares\": $_enfermedadesAntecedentesFamiliaresEnum, '
        ' \"enfermedadesPreexistentes\": $_enfermedadesPreexistentesEnum}';
  }
}
