import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_poc/providers/push_notifications_provider.dart';
import 'package:flutter_poc/services/data_connectiviy_service.dart';
import 'package:flutter_poc/widgets/home.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import 'widgets/new_paciente.dart';

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
  @override
  void initState() {
    super.initState();
    PushNotificationsProvider().initNotifications();
  }

  @override
  Widget build(BuildContext context) {
    print('el main se sigue ejecutando');
    return StreamProvider<DataConnectionStatus>(
      create: (context) {
        return DataConnectivityService().connectivityStreamController.stream;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Home(),
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
      ),
    );
  }
}
