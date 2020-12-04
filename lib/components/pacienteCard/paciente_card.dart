import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/Paciente.dart';
import '../../utils/constants.dart';
import '../../utils/paciente_utils.dart';
import '../../widgets/paciente_details.dart';
import '../../components/pacienteCard/paciente_card_name_container.dart';
import '../../components/pacienteCard/paciente_card_text.dart';

class PacienteCard extends StatelessWidget {
  final Paciente _paciente;

  PacienteCard(this._paciente);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(1, 1, 1, 0.1),
            blurRadius: 12.0,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: InkWell(
          onTap: () => {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => PacienteDetails(_paciente),
              ),
            )
          },
          child: Row(
            children: [
              SizedBox(
                width: 5,
              ),
              PacienteCardNameContainer(_paciente.name, _paciente.apellido),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            top: 20,
                            left: 10,
                            right: 15,
                            bottom: 10,
                          ),
                          child: PacienteCardText(
                            'DNI: ',
                            PacienteUtils().getDniFormatted(_paciente.dni),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            top: 20,
                            right: _paciente.peso >= 100 ? 14 : 20,
                            bottom: 10,
                          ),
                          child: PacienteCardText(
                              'Peso: ', _paciente.peso.toString() + 'kg'),
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        bottom: 20,
                        left: 10,
                        right: 20,
                      ),
                      child: PacienteCardText('Edad: ',
                          PacienteUtils().getEdad(_paciente.fechaNacimiento)),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 5.0),
                alignment: Alignment.center,
                child: Center(
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Constants.MAIN_COLOR,
                    size: 20.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
