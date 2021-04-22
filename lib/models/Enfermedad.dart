class Enfermedad {
  int _code;
  String _descripcion;

  Enfermedad(this._code, this._descripcion);

  String get descripcion => _descripcion;

  set descripcion(String value) {
    _descripcion = value;
  }

  int get code => _code;

  set code(int value) {
    _code = value;
  }

  factory Enfermedad.fromJson(Map<String, dynamic> json) {
    return Enfermedad(json['id'], json['descripcion']);
  }

  Enfermedad.fromDB(
    this._code,
    this._descripcion,
  );

  @override
  String toString() {
    return '{\"id\": $_code, \"descripcion\": \"$_descripcion\"}';
  }

  Map<String, dynamic> toMap() {
    return {
      'code': _code,
      'name': _descripcion,
    };
  }
}
