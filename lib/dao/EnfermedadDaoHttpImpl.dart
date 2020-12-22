import 'package:http/http.dart' as http;
import '../models/Enfermedad.dart';
import 'dart:convert';

class EnfermedadDaoHttpImpl {
  static final String _baseUrl = "http://10.0.2.2:8080/api/";

  Future<List<dynamic>> fetchEnfermedades(http.Client client) async {
    final response = await client.get(_baseUrl + "enfermedad");
    return jsonDecode(response.body);
  }
}
