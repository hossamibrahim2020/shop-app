import 'package:flutter/material.dart';

class AppTheme {
  static const Color unSelected = Colors.blueGrey;
  static final Color cardColor = Colors.blueGrey[50];
  static final ThemeData appTheme = ThemeData(
    primaryColor: Colors.lightBlue,
    accentColor: Colors.lightBlue.shade900,
    secondaryHeaderColor: Colors.lightBlue.shade200,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
  AppBarTheme them = AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white),
    elevation: 0.0,
  );
}
