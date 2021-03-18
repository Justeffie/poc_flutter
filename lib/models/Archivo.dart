import 'dart:io';

import 'dart:typed_data';

class Archivo {
  int _id;
  String _contentType;
  String _name;
  Uint8List _bytes;

  Archivo(this._id, this._contentType, this._name, this._bytes);

  Archivo.sinId(this._contentType, this._name, this._bytes);

  int get id => _id;

  set id(int id) => _id = id;

  String get contentType => _contentType;

  set contentType(String content) => _contentType = content;

  String get name => _name;

  set name(String nombre) => _name = nombre;

  Uint8List get bytes => _bytes;

  set bytes(Uint8List contenido) => _bytes = contenido;
}
