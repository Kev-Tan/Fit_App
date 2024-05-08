import 'package:flutter/material.dart';
import 'package:fit_app/pages/home/home.dart';
import 'package:fit_app/pages/home/home.dart';

//to homepage commit

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Home());
  }
}
