import 'package:flutter/material.dart';
import 'package:age/age.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_poc/widgets/pacienteDetails/paciente_details.dart';
import '../utils/paciente_utils.dart';
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
                itemBuilder: (context, index) {
                  return Card(
                    child: InkWell(
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PacienteDetails(pacientes[index]),
                          ),
                        )
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 114.0,
                            padding: EdgeInsets.all(16.0),
                            margin: EdgeInsets.only(left: 2.0),
                            decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  pacientes[index].name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  pacientes[index].apellido,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
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
                                            PacienteUtils().getDniFormatted(
                                                pacientes[index].dni),
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
                                            pacientes[index].peso.toString() +
                                                'kg',
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
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
                                        PacienteUtils().getEdad(
                                            pacientes[index].fechaNacimiento),
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10.0),
                            alignment: Alignment.center,
                            child: Center(
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey,
                                size: 20.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: pacientes.length,
              ),
      ),
    );
  }
}
