import 'package:flutter/material.dart';

class BottomNavigationBarHeightProvider with ChangeNotifier {
  double _height = 0.0;

  double get height => _height;

  void setHeight(double height) {
    _height = height;
    notifyListeners();
  }
}