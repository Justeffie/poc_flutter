import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_poc/utils/paciente_utils.dart';
import 'package:flutter_poc/widgets/pacienteDetails/paciente_details_text.dart';
import '../../models/Paciente.dart';

class PacienteDetails extends StatelessWidget {
  final Paciente _paciente;

  PacienteDetails(this._paciente);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del paciente'),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.greenAccent,
            padding: EdgeInsets.all(15.0),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    PacienteUtils().getNombreYApellido(_paciente),
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    PacienteUtils().getDniFormatted(_paciente.dni),
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    PacienteUtils().getEdad(_paciente.fechaNacimiento) +
                        ' ' +
                        'a\u00f1os',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(19.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PacienteDetailsText(
                  labelText: 'Fecha de nacimiento: ',
                  detailText: PacienteUtils()
                      .getFechaNacimientoFormatted(_paciente.fechaNacimiento),
                ),
                PacienteDetailsText(
                  labelText: 'Domicilio: ',
                  detailText: _paciente.domicilio,
                ),
                PacienteDetailsText(
                  labelText: 'Peso: ',
                  detailText: PacienteUtils().getPeso(_paciente),
                ),
                PacienteDetailsText(
                  labelText: 'Altura: ',
                  detailText: _paciente.altura.toStringAsFixed(2),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
