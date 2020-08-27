import 'package:flutter/material.dart';

class CustomCurveShap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size _screenSize = MediaQuery.of(context).size;
    final ThemeData _color = Theme.of(context);
    return Stack(
      children: <Widget>[
        Positioned(
          right: 0,
          child: Container(
            height: _screenSize.height * .20,
            width: _screenSize.width * .25,
            decoration: BoxDecoration(
              color: _color.accentColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(_screenSize.width * 1),
              ),
            ),
          ),
        ),
        Container(
          height: _screenSize.height * .22,
          width: _screenSize.width,
          decoration: BoxDecoration(
            color: _color.primaryColor,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(_screenSize.width * 1),
            ),
          ),
        ),
      ],
    );
  }
}
