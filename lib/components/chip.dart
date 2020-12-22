import 'package:flutter/material.dart';
import 'package:flutter_poc/utils/constants.dart';

class Chip extends StatelessWidget {
  final String data;

  Chip(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        boxShadow: [
          new BoxShadow(
            color: Color.fromRGBO(1, 1, 1, 0.1),
            blurRadius: 5.0,
            spreadRadius: 0,
          ),
        ],
        color: Constants.MAIN_COLOR,
        borderRadius: BorderRadius.circular(17),
      ),
      margin: EdgeInsets.only(
        right: 10.0,
        top: 10.0,
      ),
      child: Text(
        data,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
    );
  }
}