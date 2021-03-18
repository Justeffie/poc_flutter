import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_poc/dao/ArchivoDaoHttpImpl.dart';
import 'package:flutter_poc/models/Archivo.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DetailsHistoriaClinica extends StatelessWidget {
  final String labelText;
  final int historiaId;
  Archivo historiaClinica;

  DetailsHistoriaClinica({this.labelText, this.historiaId});

  Future<Archivo> getArchivo(Archivo historiaClinica) {
    return ArchivoDaoHttpImpl().getArchivo(historiaId);
  }

  downloadFile() async {
    ArchivoDaoHttpImpl().downloadArchivo(historiaId);
  }

  String showName() {
    String shortName = historiaClinica.name;
    if (historiaClinica.name.length > 40) {
      String shortName = historiaClinica.name.substring(0, 40) + "...";
    }

    return shortName;
  }

  Future<void> openFile(context) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = new File('$tempPath/${historiaClinica.name}');
    await file.writeAsBytes(historiaClinica.bytes);
    try {
      final result = await OpenFile.open(file.path);
    } catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
          "No se pudo abrir ${basename(file.path)}",
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Archivo>(
      future: getArchivo(historiaClinica),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        Widget child;
        if (snapshot.hasData) {
          historiaClinica = snapshot.data;
          child = InkWell(
            onTap: () => openFile(context),
            child: Text(
              showName(),
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                  decoration: TextDecoration.underline),
            ),
          );
        } else if (snapshot.hasError) {
          child = Text('Error: ${snapshot.error}');
        } else {
          child = CircularProgressIndicator();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              labelText,
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 18.0,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            child,
            SizedBox(
              height: 20,
            ),
          ],
        );
      },
    );
  }
}
