import 'package:flutter/material.dart';

class IsLodingModel extends ChangeNotifier {
  bool isLoding = false;
  void changeLoding(bool value) {
    isLoding = value;
    notifyListeners();
  }
}
