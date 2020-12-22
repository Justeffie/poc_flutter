import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dao/PacienteDaoDBImpl.dart';
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
    return MaterialApp(
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
  List<Paciente> _pacientes = [];
  List<dynamic> _pacientesHttp;


  @override
  void initState() {
    PacienteDaoHttpImpl().fetchPacientes(http.Client()).then((value) => setState(() {
      _pacientesHttp = value;
    }));
    /*PacienteDaoDBImpl().pacientes().then((value) => {
      setState(() {
        _pacientes = value;
      })
    });*/
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
          PacienteList(pacientes: _pacientesHttp),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewPaciente(),
            ),
          );
        },
      ),
    );
  }
}
