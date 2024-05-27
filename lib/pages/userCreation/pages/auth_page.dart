import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_app/pages/home/home.dart';
import 'package:fit_app/pages/main_screen.dart';
import 'package:fit_app/pages/userCreation/login_page.dart';
import 'package:flutter/material.dart';

class Authpage extends StatelessWidget {
  const Authpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return MainScreen();
              } else {
                return LoginPage();
              }
            }));
  }
}
