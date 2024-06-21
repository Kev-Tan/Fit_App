import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_app/models/user_provider.dart';
import 'package:fit_app/pages/home/home.dart';
import 'package:fit_app/pages/chat/chat.dart';
import 'package:fit_app/pages/profile/profile.dart';
import 'package:fit_app/pages/workout.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  late UserProvider userProvider; // Declare userProvider here

  final screens = [Home(), WorkoutPage(), ChatPage(userProvider: UserProvider()), ProfilePage()];

  @override
  void initState() {
    super.initState();
    userProvider = UserProvider(); // Initialize userProvider in initState
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => userProvider),
      ],
      child: Scaffold(
        extendBody: true,
        body: screens[currentIndex],
        bottomNavigationBar: FlashyTabBar(
          animationDuration: Duration(milliseconds: 300),
          backgroundColor:  Color.fromRGBO(8, 31, 92, 1), 
          //color: Color.fromARGB(255, 8, 31, 92),
          selectedIndex: currentIndex,
          items: [
            FlashyTabBarItem(
              icon: Icon(
                Icons.home,
                color: Color.fromRGBO(255, 249, 240, 1),
              ),
              title: Text(
                'Home',
                style: TextStyle(
                  color: Color.fromRGBO(255, 249, 240, 1)
                ),
              ),
            ),
            FlashyTabBarItem(
              icon: Icon(
                Icons.fitness_center,
                color: Color.fromRGBO(255, 249, 240, 1),
              ),
              title: Text(
                'Workout',
                style: TextStyle(
                  color: Color.fromRGBO(255, 249, 240, 1)
                ),
              ),
            ),
            FlashyTabBarItem(
              icon: Icon(
                Icons.chat,
                color: Color.fromRGBO(255, 249, 240, 1),
              ),
              title: Text(
                'Chat',
                style: TextStyle(
                  color: Color.fromRGBO(255, 249, 240, 1)
                ),
              ),
            ),
            FlashyTabBarItem(
              icon: Icon(
                Icons.person,
                color: Color.fromRGBO(255, 249, 240, 1),
              ),
              title: Text(
                'Profile',
                style: TextStyle(
                  color: Color.fromRGBO(255, 249, 240, 1)
                ),
              ),
            ),
          ],
          onItemSelected: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
