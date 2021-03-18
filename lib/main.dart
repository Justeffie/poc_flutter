import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_poc/providers/push_notifications_provider.dart';
import 'package:overlay_support/overlay_support.dart';
import 'dao/PacienteDaoHttpImpl.dart';
import 'package:http/http.dart' as http;

import './models/Paciente.dart';
import 'widgets/new_paciente.dart';
import 'widgets/paciente_list.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        localizationsDelegates: [GlobalMaterialLocalizations.delegate],
        supportedLocales: [
          const Locale('es'),
          const Locale('en'),
        ],
        title: 'Flutter POC',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Pacientes'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /* Metodo que hace la consulta al backend para traer los pacientes */
  Future<List<Paciente>> fetchPacientes(http.Client client) {
    PacienteDaoHttpImpl httpDao = PacienteDaoHttpImpl();
    return httpDao.fetchPacientes(client);
  }

  @override
  void initState() {
    super.initState();
    PushNotificationsProvider().initNotifications();
  }

  @override
  Widget build(BuildContext context) {
    print('el main se sigue ejecutando');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          /* Este componente hace un busqueda asincronica,
          *  Mientras no tenga la respuesta renderiza un componente, cuando
          *  llega la respuesta renderiza otro dependiendo el tipo de respuesta*/
          FutureBuilder<List<dynamic>>(
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
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          /* Se hace un push asincrono, cuando se vuelve a esta pantalla
          se hace un setState para que se vuelve a ejecutar el build y se traiga
          otra vez la lista de pacientes */
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewPaciente(),
            ),
          ).then((value) => setState(() {}));
        },
      ),
    );
  }
}
