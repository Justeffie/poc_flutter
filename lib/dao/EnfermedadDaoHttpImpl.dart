import 'package:http/http.dart' as http;
import '../models/Enfermedad.dart';
import 'dart:convert';

class EnfermedadDaoHttpImpl {

  // Esta url es para hacer request a un backend en el mismo host, es como un localhost
  static final String _baseUrl = "http://10.0.2.2:8080/api/";

  Future<List<Enfermedad>> fetchEnfermedades(http.Client client) async {
    // Hago el request y espero respuesta
    final response = await client.get(_baseUrl + "enfermedad");

    // Tomo el body de la respuesta
    var body = response.body;

    // Decodifico el JSON en una lista
    List decodedBody = jsonDecode(body);

    // Tomo cada valor de la lista y lo transformo en una Enfermedad
    var enfermedadesDecoded = decodedBody.map((e) => Enfermedad.fromJson(e));

    // El iterable creado por el map lo paso a una lista y lo devuelvo
    return enfermedadesDecoded.toList();
  }
}
