import 'package:flutter/material.dart';
import '../../utils/paciente_utils.dart';

class PacienteDetailsText extends StatelessWidget {
  final String labelText;
  final String detailText;

  PacienteDetailsText({this.labelText, this.detailText});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
          height: 2,
        ),
        Text(
          detailText,
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
