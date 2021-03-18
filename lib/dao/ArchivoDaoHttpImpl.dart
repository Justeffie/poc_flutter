import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_poc/models/Archivo.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';

class ArchivoDaoHttpImpl {
  static final String _baseUrl = "http://10.0.2.2:8080/api/";

  Future<int> saveArchivo(Archivo archivo) async {
    http.MultipartRequest request =
        new http.MultipartRequest("POST", Uri.parse(_baseUrl + "archivo"));
    request.headers['content-type'] = "multipart/form-data";
    request.files.add(
      new http.MultipartFile.fromBytes(
        "archivo",
        archivo.bytes,
        filename: archivo.name,
        contentType: new MediaType("application", "pdf"),
      ),
    );

    print(request);
    print(request.files);
    http.Response response =
        await http.Response.fromStream(await request.send());
    print("Result: ${response.statusCode}");
    if (response.statusCode == 200) {
      print(jsonDecode(response.body)['id']);
      return jsonDecode(response.body)['id'];
    }
    return -1;
  }

  Future<String> downloadArchivo(int id) async {
    Directory dir = await getApplicationDocumentsDirectory();
    final taskId = await FlutterDownloader.enqueue(
      url: _baseUrl + "archivo/" + id.toString(),
      savedDir: dir.path,
      showNotification: true,
      openFileFromNotification: true,
    );

    return taskId;
  }

  Future<Archivo> getArchivo(int id) async {
    final response = await http.get(_baseUrl + "archivo/" + id.toString());

    final archivoJson = jsonDecode(response.body);

    // Tomo cada valor de la lista y lo transformo en un Paciente
    Archivo archivo = new Archivo(
        archivoJson["id"],
        archivoJson["contentType"],
        archivoJson["nombre"],
        Base64Decoder().convert(archivoJson["contenido"]));

    // El iterable creado por el map lo paso a una lista y lo devuelvo
    return archivo;
  }
}
