import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_app/models/user_provider.dart';
import 'package:fit_app/pages/home/home.dart';
import 'package:fit_app/pages/chat/chat.dart';
import 'package:fit_app/pages/profile/profile.dart';
import 'package:fit_app/pages/workout.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  final screens = [Home(), WorkoutPage(), ChatPage(userProvider: UserProvider()), ProfilePage()];//////

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: Scaffold(
        extendBody: true,
        body: screens[currentIndex],
        bottomNavigationBar: CurvedNavigationBar(
          key: _navigatorKey,
          animationDuration: Duration(milliseconds: 300),
          backgroundColor: Colors.white,
          color: Color.fromARGB(255, 8, 31, 92),
          index: currentIndex,
          items: [
            CurvedNavigationBarItem(
              child: Icon(
                Icons.home,
                color: Colors.white,
              ),
              // label: 'Home',
            ),
            CurvedNavigationBarItem(
              child: Icon(
                Icons.fitness_center,
                color: Colors.white,
              ),
              // label: 'Workout',
            ),
            CurvedNavigationBarItem(
              child: Icon(
                Icons.chat,
                color: Colors.white,
              ),
              // label: 'Chat',
            ),
            CurvedNavigationBarItem(
              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
          ],
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}