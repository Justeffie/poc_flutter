import 'package:flutter/material.dart';
import '../components/details_text.dart';
import '../utils/constants.dart';
import '../utils/paciente_utils.dart';
import '../components/details_chips.dart';
import '../models/Paciente.dart';

class PacienteDetails extends StatelessWidget {
  final Paciente _paciente;

  PacienteDetails(this._paciente);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del paciente'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.pink, Constants.MAIN_COLOR],
                ),
                boxShadow: [
                  new BoxShadow(
                    color: Color.fromRGBO(1, 1, 1, 0.1),
                    blurRadius: 5.0,
                    spreadRadius: 0,
                  ),
                ],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
              ),
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
                  DetailsText(
                    labelText: 'Fecha de nacimiento: ',
                    detailText: PacienteUtils()
                        .getFechaNacimientoFormatted(_paciente.fechaNacimiento),
                  ),
                  DetailsText(
                    labelText: 'Domicilio: ',
                    detailText: _paciente.domicilio,
                  ),
                  DetailsText(
                    labelText: 'Peso: ',
                    detailText: PacienteUtils().getPeso(_paciente),
                  ),
                  DetailsText(
                    labelText: 'Altura: ',
                    detailText: _paciente.altura.toStringAsFixed(2),
                  ),
                  _paciente.enfermedadesPreexistentes.isNotEmpty
                      ? DetailsChips(
                          labelText: "Enfermedades preexistentes: ",
                          dataText: _paciente.enfermedadesPreexistentes,
                        )
                      : SizedBox(
                          height: 2,
                        ),
                  SizedBox(
                    height: _paciente.enfermedadesAntecedentesFamiliares
                                .isNotEmpty &&
                            _paciente.enfermedadesPreexistentes.isNotEmpty
                        ? 20
                        : 2,
                  ),
                  _paciente.enfermedadesAntecedentesFamiliares.isNotEmpty
                      ? DetailsChips(
                          labelText: "Antecedentes familiares: ",
                          dataText:
                              _paciente.enfermedadesAntecedentesFamiliares,
                        )
                      : SizedBox(
                          height: 2,
                        ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
