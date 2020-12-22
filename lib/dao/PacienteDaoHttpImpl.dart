import 'package:http/http.dart' as http;
import '../models/Paciente.dart';
import 'dart:convert';

class PacienteDaoHttpImpl {

  static final String _baseUrl = "http://10.0.2.2:8080/api/";

  Future<List<Paciente>> fetchPacientes(http.Client client) async {
    final response = await client.get(_baseUrl + "paciente");

    final listPacientes = jsonDecode(response.body) as List<dynamic>;
    final List<Paciente> pacientes = [];

    listPacientes.forEach((paciente) {
      pacientes.add(Paciente.fromJson(paciente));
    });
    return pacientes;
  }

  Future<Paciente> savePaciente(http.Client client, Paciente paciente) async {
    final response = await client.post(_baseUrl + "pacientes", body: jsonEncode(paciente));
    return Paciente.fromJson(jsonDecode(response.body));
  }

}
