import 'package:fit_app/pages/userCreation/forgot_password_page.dart';
import 'package:fit_app/pages/userCreation/login_page.dart';
import 'package:fit_app/pages/userCreation/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:fit_app/pages/home/home.dart';
import 'package:fit_app/pages/home/home.dart';

//to homepage commit 222 (new, alongside the updated userCreation Page)x
//So now Kevin wants to be gay
//Kevin Joking now, no cap
//second changes, Kevin has beecome Kein

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
