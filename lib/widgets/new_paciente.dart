import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_poc/widgets/form_imput.dart';

class NewPaciente extends StatefulWidget {
  static final formKey = new GlobalKey<FormState>();

  @override
  _NewPacienteState createState() => _NewPacienteState();
}

class _NewPacienteState extends State<NewPaciente> {
  final _fechaNacController = TextEditingController();
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _dniController = TextEditingController();
  final _pesoController = TextEditingController();
  final _alturaController = TextEditingController();
  final _domicilioController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  String validation(String value) {
    if (value.isEmpty) {
      return "Campo requerido";
    }
  }

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
              Row(
                children: [
                  Expanded(
                    child: FormInput(
                      labelText: "Nombre",
                      validator: (String value) => validation(value),
                      isNumber: false,
                      isText: true,
                      controller: _nombreController,
                    ),
                  ),
                  Expanded(
                    child: FormInput(
                      labelText: "Apellido",
                      validator: (String value) => validation(value),
                      isNumber: false,
                      isText: true,
                      controller: _apellidoController,
                    ),
                  ),
                ],
              ),
              FormInput(
                labelText: "Domicilio",
                hintText: "Calle, N\u00FAmero, Ciudad, Provincia",
                validator: (String value) => validation(value),
                isNumber: false,
                isText: false,
                controller: _domicilioController,
              ),
              Row(
                children: [
                  Expanded(
                    child: FormInput(
                      labelText: "DNI",
                      validator: (String value) => validation(value),
                      isNumber: true,
                      isText: false,
                      controller: _dniController,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Fecha de nacimiento",
                            contentPadding: EdgeInsets.all(15.0),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.lightGreen)),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (String value) => validation(value),
                          showCursor: true,
                          readOnly: true,
                          controller: _fechaNacController,
                          onTap: () => _selectDate(context),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: FormInput(
                      labelText: "Peso",
                      validator: (String value) => validation(value),
                      isNumber: true,
                      isText: false,
                      controller: _pesoController,
                    ),
                  ),
                  Expanded(
                    child: FormInput(
                      labelText: "Altura",
                      validator: (String value) => validation(value),
                      isNumber: true,
                      isText: false,
                      controller: _alturaController,
                    ),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                child: FlatButton(
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
