import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_poc/models/Enfermedad.dart';
import 'package:flutter_poc/dao/EnfermedadDaoHttpImpl.dart';
import 'package:flutter_poc/dao/PacienteDaoHttpImpl.dart';
import '../dao/PacienteDaoDBImpl.dart';
import '../main.dart';
import '../components/gradient_button.dart';
import '../components/datepicker.dart';
import '../components/multiselect.dart';
import '../components/form_imput.dart';
import '../models/Paciente.dart';
import 'package:http/http.dart' as http;

class NewPaciente extends StatelessWidget {
  static final formKey = new GlobalKey<FormState>();
  final _fechaNacController = TextEditingController();
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _dniController = TextEditingController();
  final _pesoController = TextEditingController();
  final _alturaController = TextEditingController();
  final _domicilioController = TextEditingController();
  HashMap<int, dynamic> _enfermedadesPreexistentes;
  HashMap<int, dynamic> _antecedentesFamiliares;

  Future<List<dynamic>> fetchEnfermedades(http.Client client) {
    EnfermedadDaoHttpImpl httpDao = EnfermedadDaoHttpImpl();
    return httpDao.fetchEnfermedades(client);
  }

  String validation(String value, int campoLength, double number) {
    if (value.isEmpty) {
      return "Campo requerido";
    }

    if ((campoLength != null && (value.length >= campoLength)) ||
        (number != null && double.parse(value) > number)) {
      return "No es un valor v\u00E1lido ";
    }
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        locale: const Locale("es"),
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900, 1),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      _fechaNacController.text = picked.day.toString() +
          "/" +
          picked.month.toString() +
          "/" +
          picked.year.toString();
    }
  }

  Paciente buildPaciente() {
    return Paciente.paraGuardar(
      _nombreController.text,
      _apellidoController.text,
      int.tryParse(_dniController.text),
      _domicilioController.text,
      double.tryParse(_pesoController.text),
      double.tryParse(_alturaController.text),
      selectedDate.toLocal().millisecondsSinceEpoch,
      "", ""
    );
  }

  _save(BuildContext context) {
    if (NewPaciente.formKey.currentState.validate()) {
      PacienteDaoHttpImpl httpDao = PacienteDaoHttpImpl();
      httpDao.savePaciente(http.Client(), buildPaciente());

      PacienteDaoDBImpl().insertPaciente(buildPaciente());
      Navigator.pop(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    }
  }

  _setEnfermedadesPreexistentes(HashMap<int, dynamic> enfermedades) {
    _enfermedadesPreexistentes = enfermedades;
  }

  _setAntecedentesFamiliares(HashMap<int, dynamic> enfermedades) {
    _antecedentesFamiliares = enfermedades;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nuevo"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: NewPaciente.formKey,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: FormInput(
                      labelText: "Nombre",
                      validator: (String value) =>
                          validation(value, null, null),
                      isNumber: false,
                      isText: true,
                      controller: _nombreController,
                    ),
                  ),
                  Expanded(
                    child: FormInput(
                      labelText: "Apellido",
                      validator: (String value) =>
                          validation(value, null, null),
                      isNumber: false,
                      isText: true,
                      controller: _apellidoController,
                    ),
                  ),
                ],
              ),
              FormInput(
                labelText: "Domicilio",
                hintText: "Calle, N\u00FAmero, Localidad, Provincia",
                validator: (String value) => validation(value, null, null),
                isNumber: false,
                isText: false,
                controller: _domicilioController,
              ),
              Row(
                children: [
                  Expanded(
                    child: FormInput(
                      labelText: "DNI",
                      validator: (String value) => validation(value, 9, null),
                      isNumber: true,
                      isText: false,
                      controller: _dniController,
                    ),
                  ),
                  DatePicker(validation, _fechaNacController, _selectDate,
                      "Fecha de nacimiento"),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: FormInput(
                      labelText: "Peso",
                      validator: (String value) => validation(value, 4, null),
                      isNumber: true,
                      isText: false,
                      controller: _pesoController,
                    ),
                  ),
                  Expanded(
                    child: FormInput(
                      labelText: "Altura",
                      validator: (String value) => validation(value, null, 3.0),
                      isNumber: true,
                      isText: false,
                      controller: _alturaController,
                    ),
                  )
                ],
              ),
              FutureBuilder<List<dynamic>>(
                future: fetchEnfermedades(http.Client()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Multiselect(
                          labelText: 'Enfermedades Preexistentes',
                          data: snapshot.data,
                          hintText: 'Seleccione uno o m\u00E1s',
                          valuesSelect: _enfermedadesPreexistentes,
                          setter: _setEnfermedadesPreexistentes,
                        ),
                        Multiselect(
                          labelText: 'Antecedentes Familiares',
                          data: snapshot.data,
                          hintText: 'Seleccione uno o m\u00E1s',
                          valuesSelect: _antecedentesFamiliares,
                          setter: _setAntecedentesFamiliares,
                        )
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  // By default, show a loading spinner.
                  return CircularProgressIndicator();
                },
              ),
              GradientButton(_save, "Guardar"),
            ],
          ),
        ),
      ),
    );
  }
}
