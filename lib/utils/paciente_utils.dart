import 'package:age/age.dart';
import '../models/Paciente.dart';

class PacienteUtils {
  String getEdad(int date) {
    DateTime dateDT = new DateTime.fromMillisecondsSinceEpoch(date);
    return Age.dateDifference(
            fromDate: dateDT, toDate: DateTime.now(), includeToDate: false)
        .years
        .toString();
  }

  String getDniFormatted(int dni) {
    String formattedDni = dni.toString();
    String bg = formattedDni.substring(0, 2);
    String md = formattedDni.substring(2, 5);
    String end = formattedDni.substring(5, 8);
    return bg + "." + md + "." + end;
  }

  String getNombreYApellido(Paciente paciente) {
    return paciente.name + " " + paciente.apellido;
  }

  String getFechaNacimientoFormatted(int milisegundos) {
    DateTime dateDT = new DateTime.fromMillisecondsSinceEpoch(milisegundos);
    return dateDT.day.toString() +
        "/" +
        dateDT.month.toString() +
        "/" +
        dateDT.year.toString();
  }

  String getPeso(Paciente paciente) {
    return paciente.peso.toString() + 'kg';
  }

  String generateEnfermedades(List<String> enfermedades) {
    return enfermedades.join(", ");
  }
}
