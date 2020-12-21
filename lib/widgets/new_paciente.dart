import 'package:flutter/material.dart';
import '../dao/PacienteDao.dart';
import '../main.dart';
import '../components/gradient_button.dart';
import '../components/datepicker.dart';
import '../components/multiselect.dart';
import '../components/form_imput.dart';
import '../models/Paciente.dart';

class NewPaciente extends StatelessWidget {
  static final formKey = new GlobalKey<FormState>();
  final _fechaNacController = TextEditingController();
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _dniController = TextEditingController();
  final _pesoController = TextEditingController();
  final _alturaController = TextEditingController();
  final _domicilioController = TextEditingController();
  List _enfermedadesPreexistentes;
  List _antecedentesFamiliares;

  List get _enfermedades {
    return [
      {
        "code": "Diabetes",
        "value": "Diabetes",
      },
      {
        "code": "Cancer",
        "value": "Cancer",
      },
      {
        "code": "Asma",
        "value": "Asma",
      },
      {
        "code": "Obesidad",
        "value": "Obesidad",
      },
      {
        "code": "Parkinson",
        "value": "Parkinson",
      },
      {
        "code": "Artrosis",
        "value": "Artrosis",
      },
      {
        "code": "EPOC",
        "value": "EPOC",
      },
      {
        "code": "Epilepsia",
        "value": "Epilepsia",
      },
      {
        "code": "Lupus",
        "value": "Lupus",
      },
    ];
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

  String dniValidation(String value, int tam) {
    if (value.isEmpty) {
      return "Campo requerido";
    }

    if (tam != value.length) {
      return "El campo debe tener 8 digitos";
    }

    if (value.length > tam) {
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
      _antecedentesFamiliares != null ? _antecedentesFamiliares.join(', ') : "",
      _enfermedadesPreexistentes != null
          ? _enfermedadesPreexistentes.join(', ')
          : "",
    );
  }

  _save(BuildContext context) {
    if (NewPaciente.formKey.currentState.validate()) {
      PacienteDao().insertPaciente(buildPaciente());
      Navigator.pop(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    }
  }

  _setEnfermedadesPreexistentes(List enfermedades) {
    _enfermedadesPreexistentes = enfermedades;
  }

  _setAntecedentesFamiliares(List enfermedades) {
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
          key: formKey,
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
                      validator: (String value) => dniValidation(value, 8),
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
              Multiselect(
                labelText: 'Enfermedades Preexistentes',
                data: _enfermedades,
                hintText: 'Seleccione uno o m\u00E1s',
                valuesSelect: _enfermedadesPreexistentes,
                setter: _setEnfermedadesPreexistentes,
              ),
              Multiselect(
                labelText: 'Antecedentes Familiares',
                data: _enfermedades,
                hintText: 'Seleccione uno o m\u00E1s',
                valuesSelect: _antecedentesFamiliares,
                setter: _setAntecedentesFamiliares,
              ),
              GradientButton(_save, "Guardar"),
            ],
          ),
        ),
      ),
    );
  }
}
