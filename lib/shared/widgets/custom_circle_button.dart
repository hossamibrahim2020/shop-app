import 'package:flutter/material.dart';
import '../constants.dart';

class CustomCircleButton extends StatelessWidget {
  final Color color;
  final String label;
  final Function onpress;
  final double horizontal, vertical;
  CustomCircleButton({
    @required this.label,
    @required this.color,
    @required this.onpress,
    @required this.vertical,
    @required this.horizontal,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: FlatButton(
        onPressed: onpress,
        child: Container(
          child: Center(
              child: Text(
            label,
            style: kauthStyle,
          )),
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
          ),
        ),
      ),
    );
  }
}
