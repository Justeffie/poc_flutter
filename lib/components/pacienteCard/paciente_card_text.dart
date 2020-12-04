import 'package:flutter/material.dart';

class PacienteCardText extends StatelessWidget {
  final String labelText;
  final String descriptionText;

  PacienteCardText(this.labelText, this.descriptionText);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          labelText,
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
        ),
        Text(
          descriptionText,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
