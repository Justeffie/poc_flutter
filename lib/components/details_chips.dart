import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'package:flutter_poc/components/chip.dart' as Chip;

class DetailsChips extends StatelessWidget {
  final String labelText;
  final List<dynamic> data;

  DetailsChips({this.labelText, this.data});

  @override
  Widget build(BuildContext context) {
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
        Wrap(
          children:
            data.map((enfermedad) {
              return Chip.Chip(enfermedad["descripcion"]);
            }).toList()
        )
      ]
    );
  }
}


