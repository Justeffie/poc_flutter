import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_poc/models/Enfermedad.dart';
import '../utils/constants.dart';
import 'multiselect_formfield/multiselect_formfield.dart';

class Multiselect extends StatefulWidget {
  final data;
  final labelText;
  var valuesSelect;
  final hintText;
  final Function setter;

  Multiselect(
      {this.data,
      this.labelText,
      this.valuesSelect,
      this.hintText,
      this.setter});

  @override
  _MultiselectState createState() => _MultiselectState();
}

class _MultiselectState extends State<Multiselect> {
  @override
  void initState() {
    super.initState();
    widget.valuesSelect = [];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      padding: EdgeInsets.all(10.0),
      child: MultiSelectFormField(
        autovalidate: false,
        chipBackGroundColor: Constants.MAIN_COLOR,
        chipLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        dialogTextStyle: TextStyle(fontWeight: FontWeight.normal),
        checkBoxActiveColor: Constants.MAIN_COLOR,
        checkBoxCheckColor: Colors.white,
        dialogShapeBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        title: Text(
          widget.labelText,
          style: TextStyle(fontSize: 16),
        ),
        dataSource: widget.data,
        textField: 'descripcion',
        valueField: 'code',
        okButtonLabel: 'OK',
        cancelButtonLabel: 'CANCELAR',
        hintWidget: Text(widget.hintText),
        initialValue: widget.valuesSelect,
        onSaved: (value) {
          if (value == null) return;
          setState(() {
            List<Enfermedad> enfermedades = widget.data;
            HashMap<int, dynamic> enfermedadesSeleccionadas = HashMap();
            List<Enfermedad> enfermedadesSeleccionadasList = List();

            for (int i = 0; i < value.length; ++i) {
              for (int j = 0; j < enfermedades.length; ++j) {
                if (enfermedades[j].code == value[i]) {
                  enfermedadesSeleccionadas.putIfAbsent(
                      enfermedades[0].code, () => enfermedades[0].descripcion);
                  enfermedadesSeleccionadasList.add(enfermedades[j]);
                }
                /*if(enfermedades[j]["id"] == value[i]) {
                  enfermedadesSeleccionadas.putIfAbsent(enfermedades[0]["id"], () => enfermedades[0]["descripcion"]);
                  enfermedadesSeleccionadasList.add(enfermedades[j]);
                }*/
              }
            }
            widget.valuesSelect = value;
            widget.setter(enfermedadesSeleccionadasList);
          });
        },
      ),
    );
  }
}
