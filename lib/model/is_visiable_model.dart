import 'package:flutter/material.dart';

class IsVisiabelModel extends ChangeNotifier {
  bool isVisiable = true;
  void changeVisiable(bool value) {
    isVisiable = value;
    notifyListeners();
  }
}
