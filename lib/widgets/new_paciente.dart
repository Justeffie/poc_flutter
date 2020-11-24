import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_poc/widgets/form_imput.dart';

class NewPaciente extends StatefulWidget {
  static final formKey = new GlobalKey<FormState>();

  @override
  _NewPacienteState createState() => _NewPacienteState();
}

class _NewPacienteState extends State<NewPaciente> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: NewPaciente.formKey,
      child: Column(
        children: [
          FormInput(
            hintText: "Nombre",
            validator: (String value) {
              if (value.isEmpty) {
                return "El nombre es requerido";
              }
            },
            isNumber: false,
            isText: true,
          ),
          FormInput(
            hintText: "Apellido",
            validator: (String value) {
              if (value.isEmpty) {
                return "El apellido es requerido";
              }
            },
            isNumber: false,
            isText: true,
          ),
          FlatButton(
            onPressed: () {
              if (NewPaciente.formKey.currentState.validate()) {}
            },
            child: Text(
              'Guardar',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            color: Colors.green,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.green)),
          )
        ],
      ),
    );
  }
}
