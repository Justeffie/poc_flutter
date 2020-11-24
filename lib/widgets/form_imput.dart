import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  final String labelText;
  final String hintText;
  final Function validator;
  final Function onSaved;
  final bool isText;
  final bool isNumber;
  final controller;

  FormInput(
      {this.labelText,
      this.validator,
      this.onSaved,
      this.isText = false,
      this.isNumber = false,
      this.controller,
      this.hintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: new BorderRadius.circular(10.0),
        ),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            contentPadding: EdgeInsets.all(15.0),
            border: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.lightGreen)),
          ),
          validator: validator,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        ),
      ),
    );
  }
}
