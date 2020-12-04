import 'package:flutter/material.dart';

class DetailsText extends StatelessWidget {
  final String labelText;
  final String detailText;

  DetailsText({this.labelText, this.detailText});

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
