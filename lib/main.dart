import 'package:fit_app/pages/userCreation/forgot_password_page.dart';
import 'package:fit_app/pages/userCreation/login_page.dart';
import 'package:fit_app/pages/userCreation/pages/form.dart';
import 'package:fit_app/pages/userCreation/signup_page.dart';
import 'package:fit_app/pages/home/home.dart';
import 'package:fit_app/pages/userCreation/pages/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:fit_app/utilities/bottom_navigation_bar_height_provider.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  tz.initializeTimeZones(); //to initialize the timezones we are using 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BottomNavigationBarHeightProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Authpage(), //FormPage to open the Fill In Data page, Authpage to go to the main user page
      ),
    );
  }
}