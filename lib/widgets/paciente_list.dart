import 'package:flutter/material.dart';
import '../models/Paciente.dart';

class PacienteList extends StatelessWidget {
  final List<Paciente> pacientes;

  PacienteList({this.pacientes});

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
                                      pacientes[index].dni.toString(),
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
                                      '55kg'
                                      /*pacientes[index].peso.toString()*/,
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
                                  '15'
                                  /*pacientes[index].peso.toString()*/,
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
