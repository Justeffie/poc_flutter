import 'package:http/http.dart' as http;
import '../models/Paciente.dart';
import 'dart:convert';

class PacienteDaoHttpImpl {

  // Esta url es para hacer request a un backend en el mismo host, es como un localhost
  static final String _baseUrl = "http://10.0.2.2:8080/api/";

  Future<List<Paciente>> fetchPacientes(http.Client client) async {
    // Hago el request y espero respuesta
    final response = await client.get(_baseUrl + "paciente");

    // Tomo el body de la respuesta y decodifico el json como una lista de valores dinamicos
    final listPacientes = jsonDecode(response.body) as List<dynamic>;

    // Tomo cada valor de la lista y lo transformo en un Paciente
    var pacientes = listPacientes.map((p) => Paciente.fromJson(p));

    // El iterable creado por el map lo paso a una lista y lo devuelvo
    return pacientes.toList();
  }

  Future<Paciente> savePaciente(http.Client client, Paciente paciente) async {
    // Paso el paciente a un json reconocido por la api
    var json = paciente.toJson();
    
    // Hago el request pasandole el content type en el header y el json creado en el body
    final response = await client.post(_baseUrl + "paciente", headers: {"Content-Type": "application/json"}, body: json);
    
    // Tomo la respuesta del post y la transformo en un paciente
    // Seguramente hay una mejor forma de hacer esto pero hay que hacer mas investigacion
    var pacienteCreated = Paciente.fromJson(jsonDecode(response.body));
    print(pacienteCreated.toMap());
    return pacienteCreated;
  }

}
