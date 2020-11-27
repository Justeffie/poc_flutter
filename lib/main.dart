import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_poc/dao/PacienteDao.dart';

import './models/Paciente.dart';
import './widgets/new_paciente.dart';
import './widgets/paciente_list.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  /*PacienteDao pacientedao = PacienteDao();
  pacientedao.deleteAll();*/
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
        primarySwatch: Colors.blue,
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

void _startAddNewPaciente(BuildContext ctx) {
  showModalBottomSheet(
    context: ctx,
    builder: (_) {
      return GestureDetector(
        onTap: () {},
        child: NewPaciente(),
        behavior: HitTestBehavior.opaque,
      );
    },
  );
}

class _MyHomePageState extends State<MyHomePage> {
  List<Paciente> _pacientes = [];

  @override
  Widget build(BuildContext context) {
    PacienteDao().pacientes().then((value) => {
          setState(() {
            _pacientes = value;
          })
        });

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          PacienteList(pacientes: _pacientes),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewPaciente()));
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
