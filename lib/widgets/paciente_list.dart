import 'package:flutter/material.dart';
import '../components/pacienteCard/paciente_card.dart';
import '../models/Paciente.dart';

class PacienteList extends StatelessWidget {
  final List<Paciente> pacientes;

  PacienteList({this.pacientes});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: pacientes.isEmpty
            ? Center(
                child: Text(
                  'No hay pacientes agregados',
                  style: ThemeData.light().textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
              )
            : ListView.builder(
                itemCount: pacientes.length,
                itemBuilder: (context, index) {
                  return PacienteCard(pacientes[index]);
                },
              ),
      ),
    );
  }
}
