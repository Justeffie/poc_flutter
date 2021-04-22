import 'package:flutter_poc/dao/EnfermedadDaoDBImpl.dart';
import 'package:flutter_poc/dao/EnfermedadDaoHttpImpl.dart';
import 'package:flutter_poc/models/Enfermedad.dart';
import 'package:http/http.dart' as http;

class EnfermedadApiProvider {
  Future<List<Enfermedad>> getAllEnfermedades() async {
    Future<List<Enfermedad>> enfermedades =
        EnfermedadDaoHttpImpl().fetchEnfermedades(http.Client());

    return (enfermedades as List).map((enfermedad) {
      print('Inserting $enfermedad');
      EnfermedadDaoDBImpl().insertEnfermedad(Enfermedad.fromJson(enfermedad));
    }).toList();
  }
}
