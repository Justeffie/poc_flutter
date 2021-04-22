import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_poc/widgets/paciente_list.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_poc/dao/PacienteDaoHttpImpl.dart';
import 'package:flutter_poc/models/Paciente.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  /* Metodo que hace la consulta al backend para traer los pacientes */
  Future<List<Paciente>> fetchPacientes(http.Client client) {
    PacienteDaoHttpImpl httpDao = PacienteDaoHttpImpl();
    return httpDao.fetchPacientes(client);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Visibility(
            visible: Provider.of<DataConnectionStatus>(context) ==
                DataConnectionStatus.disconnected,
            child: Center(
                child: Text(
              "No hay internet",
              style: TextStyle(fontSize: 18),
            ))),
        /* Este componente hace un busqueda asincronica,
            *  Mientras no tenga la respuesta renderiza un componente, cuando
            *  llega la respuesta renderiza otro dependiendo el tipo de respuesta*/
        Visibility(
          visible: Provider.of<DataConnectionStatus>(context) ==
              DataConnectionStatus.connected,
          child: FutureBuilder<List<dynamic>>(
            future: fetchPacientes(http.Client()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return PacienteList(pacientes: snapshot.data);
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Center(
                  child: Text(
                    "Error al intentar recuperar la lista de pacientes",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }
              // By default, show a loading spinner.
              return Center(child: CircularProgressIndicator());
            },
          ),
        )
      ],
    );
  }
}
