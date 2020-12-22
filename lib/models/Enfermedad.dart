class Enfermedad {
  int _code;
  String _nombre;

  Enfermedad(this._code, this._nombre);

  String get nombre => _nombre;

  set nombre(String value) {
    _nombre = value;
  }

  int get code => _code;

  set code(int value) {
    _code = value;
  }

  factory Enfermedad.fromJson(Map<String, dynamic> json) {
    return Enfermedad(
        json['id'],
        json['descripcion']
    );
  }
}