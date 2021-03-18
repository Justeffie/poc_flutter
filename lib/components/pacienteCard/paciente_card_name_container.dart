import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class PacienteCardNameContainer extends StatelessWidget {
  final String name;
  final String apellido;

  PacienteCardNameContainer(this.name, this.apellido);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 114.0,
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.only(left: 2.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Constants.MAIN_COLOR, Colors.pink],
        ),
        boxShadow: [
          new BoxShadow(
            color: Color.fromRGBO(1, 1, 1, 0.1),
            blurRadius: 2.0,
            spreadRadius: 0,
          ),
        ],
        color: Constants.MAIN_COLOR,
        borderRadius: BorderRadius.circular(13.0),
      ),
      child: Column(
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            apellido,
            style: TextStyle(
              fontSize: apellido.length >= 11 ? 15 : 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
