import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatePicker extends StatelessWidget {
  Function validation;
  var fechaNacController;
  Function selectDate;
  String labelText;

  DatePicker(this.validation, this.fechaNacController, this.selectDate,
      this.labelText);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: new BorderRadius.circular(10.0),
          ),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: labelText,
              contentPadding: EdgeInsets.all(15.0),
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.lightGreen),
              ),
            ),
            keyboardType: TextInputType.number,
            validator: (String value) => validation(value, null, null),
            showCursor: true,
            readOnly: true,
            controller: fechaNacController,
            onTap: () => selectDate(context),
          ),
        ),
      ),
    );
  }
}
