import 'package:fit_app/pages/userCreation/forgot_password_page.dart';
import 'package:fit_app/pages/userCreation/login_page.dart';
import 'package:fit_app/pages/userCreation/pages/auth_page.dart';
import 'package:fit_app/pages/userCreation/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:fit_app/pages/home/home.dart';
import 'package:fit_app/pages/home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Authpage(),
    );
  }
}
