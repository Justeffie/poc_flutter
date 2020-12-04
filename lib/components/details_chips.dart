import 'package:flutter/material.dart';
import '../utils/constants.dart';

class DetailsChips extends StatelessWidget {
  final String labelText;
  final String dataText;

  DetailsChips({this.labelText, this.dataText});

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
            children: dataText
                .split(",")
                .map((item) => Container(
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
                        item,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ))
                .toList()),
      ],
    );
  }
}
