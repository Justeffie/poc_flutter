import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:flutter_poc/dao/ArchivoDaoHttpImpl.dart';
import 'package:flutter_poc/models/Archivo.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:open_file/open_file.dart';

class SelectFile extends StatefulWidget {
  String filename;
  final String labelText;
  final String buttonText;
  final Function setter;
  File fileSelected;

  SelectFile({this.labelText, this.buttonText, this.setter});

  @override
  _SelectFileState createState() => _SelectFileState();
}

class _SelectFileState extends State<SelectFile> {
  @override
  void initState() {
    super.initState();
    widget.filename = null;
    widget.fileSelected = null;
  }

  selectFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc'],
    );

    if (result != null) {
      Archivo archivo;
      widget.fileSelected = File(result.files.single.path);
      widget.fileSelected.readAsBytes().then((value) async {
        Archivo archivo = new Archivo.sinId(
          lookupMimeType(result.files.single.path),
          result.files.first.name,
          value,
        );
        int id = await ArchivoDaoHttpImpl().saveArchivo(archivo);
        archivo.id = id;
        widget.setter(widget.fileSelected, id);
      });
      setState(() {
        String shortName = result.files.first.name;
        if (shortName.length > 23) {
          shortName = shortName.substring(0, 23) + "...";
        }

        widget.filename = shortName;
      });
    }
  }

  Future<void> openFile(File file, context) async {
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

  deleteFile() {
    setState(() {
      widget.filename = null;
      widget.fileSelected = null;
      widget.setter(null, null);
    });
  }

  _launchURL(File file, context) async {
    if (await canLaunch("http://flutter.dev")) {
      await launch("http://flutter.dev");
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
          "No se pudo abrir ${basename(file.path)}",
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 21, right: 15),
          child: Text(
            widget.labelText,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        widget.filename != null
            ? InkWell(
                onTap: () => openFile(widget.fileSelected, context),
                child: Text(
                  widget.filename,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      decoration: TextDecoration.underline),
                ),
              )
            : FlatButton(
                onPressed: () => selectFile(),
                child: Text(
                  widget.buttonText,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Theme.of(context).primaryColor),
                ),
              ),
        widget.filename != null
            ? IconButton(
                onPressed: () => deleteFile(),
                icon: Icon(Icons.cancel),
              )
            : SizedBox(
                height: 20,
              ),
      ],
    );
  }
}
