import 'package:flutter/material.dart';
import 'package:age/age.dart';
import '../models/Paciente.dart';

class PacienteList extends StatelessWidget {
  final List<Paciente> pacientes;

  PacienteList({this.pacientes});

  String getEdad(int date) {
    DateTime dateDT = new DateTime.fromMillisecondsSinceEpoch(date);
    return Age.dateDifference(
            fromDate: dateDT, toDate: DateTime.now(), includeToDate: false)
        .years
        .toString();
  }

  String dniFormatter(int dni) {
    String formattedDni = dni.toString();
    String bg = formattedDni.substring(0, 2);
    String md = formattedDni.substring(2, 5);
    String end = formattedDni.substring(5, 8);
    return bg + "." + md + "." + end;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: pacientes.isEmpty
          ? Center(
              child: Text(
                'No hay pacientes agregados',
                style: ThemeData.light().textTheme.headline6,
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Container(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Text(
                                    pacientes[index].name,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    pacientes[index].apellido,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  top: 20,
                                  left: 20,
                                  right: 20,
                                  bottom: 10,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'DNI: ',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      dniFormatter(pacientes[index].dni),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  top: 20,
                                  right: 20,
                                  bottom: 10,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'Peso: ',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      pacientes[index].peso.toString() + 'kg',
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              bottom: 20,
                              left: 20,
                              right: 20,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  'Edad: ',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  getEdad(pacientes[index].fechaNacimiento),
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
              itemCount: pacientes.length,
            ),
    );
  }
}
