import 'package:fit_app/pages/userCreation/forgot_password_page.dart';
import 'package:fit_app/pages/userCreation/login_page.dart';
import 'package:fit_app/pages/userCreation/pages/form.dart';
import 'package:fit_app/pages/userCreation/signup_page.dart';
import 'package:fit_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:fit_app/pages/home/home.dart';
import 'package:fit_app/pages/userCreation/pages/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:fit_app/utilities/bottom_navigation_bar_height_provider.dart';
import 'package:provider/provider.dart';

void main() async {
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomNavigationBarHeightProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Authpage(), //FormPage to open the Fill In Data page, Authpage to go to the main user page
            theme: themeProvider.themeData,
          );
        },
      ),
    );
  }
}
