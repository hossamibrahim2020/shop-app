import 'package:flutter/material.dart';
import '../constants.dart';

class CustomCircleButton extends StatelessWidget {
  final Color color;
  final String label;
  final Function onpress;
  CustomCircleButton({
    @required this.label,
    @required this.color,
    @required this.onpress,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
