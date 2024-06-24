import 'package:flutter/material.dart';

// Define your light and dark mode themes
ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Color.fromRGBO(255, 249, 240, 1),
    primary: Color.fromRGBO(8, 31, 92, 1),
    secondary: Color.fromRGBO(112, 150, 209, 1),
    //tertiary: Color.fromRGBO(247, 242, 235, 1),
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Color.fromRGBO(8, 31, 92, 1),
    primary: Color.fromRGBO(255, 249, 240, 1),
    secondary: Color.fromRGBO(186, 214, 235, 1),
    //tertiary: Color.fromRGBO(247, 242, 235, 1),
  ),
);

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  ThemeData get themeData => _isDarkMode ? darkMode : lightMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  bool get isDarkMode => _isDarkMode;
}
