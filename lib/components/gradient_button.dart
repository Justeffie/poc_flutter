import 'package:flutter/material.dart';
import '../utils/constants.dart';

class GradientButton extends StatelessWidget {
  Function save;
  String valueText;

  GradientButton(this.save, this.valueText);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 20.0,
        bottom: 20.0,
      ),
      child: FlatButton(
        padding: EdgeInsets.only(
          left: 48.0,
          right: 48.0,
          top: 10.0,
          bottom: 10.0,
        ),
        onPressed: () => save(context),
        child: Container(
          padding:
              EdgeInsets.only(top: 15.0, bottom: 15.0, right: 90.0, left: 90.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.pink, Constants.MAIN_COLOR],
            ),
          ),
          child: Text(
            valueText,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
