import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:fit_app/pages/workout/pages/workout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_app/models/user_provider.dart';
import 'package:fit_app/pages/home/home.dart';
import 'package:fit_app/pages/chat/chat.dart';
import 'package:fit_app/pages/profile/profile.dart';
import 'package:fit_app/pages/workout/pages/workoutHome.dart';
import 'workout/pages/workoutHome.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  //final screens = [Home(), WorkoutPage(), ChatPage(), ProfilePage(userProvider: UserProvider())];
  late UserProvider userProvider; // Declare userProvider here

  final screens = [
    Home(),
    WorkoutHomePage(),
    ChatPage(userProvider: UserProvider()),
    ProfilePage(userProvider: UserProvider()),
  ];

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
          backgroundColor: Theme.of(context).colorScheme.primary,
          //color: Color.fromARGB(255, 8, 31, 92),
          selectedIndex: currentIndex,
          items: [
            FlashyTabBarItem(
              icon: Icon(
                Icons.home,
                color: Theme.of(context).colorScheme.background,
              ),
              title: Text(
                'Home',
                style: TextStyle(color: Theme.of(context).colorScheme.background),
              ),
            ),
            FlashyTabBarItem(
              icon: Icon(
                Icons.fitness_center,
                color: Theme.of(context).colorScheme.background,
              ),
              title: Text(
                'Workout',
                style: TextStyle(color: Theme.of(context).colorScheme.background),
              ),
            ),
            FlashyTabBarItem(
              icon: Icon(
                Icons.chat,
                color: Theme.of(context).colorScheme.background,
              ),
              title: Text(
                'Chat',
                style: TextStyle(color: Theme.of(context).colorScheme.background),
              ),
            ),
            FlashyTabBarItem(
              icon: Icon(
                Icons.person,
                color: Theme.of(context).colorScheme.background,
              ),
              title: Text(
                'Profile',
                style: TextStyle(color: Theme.of(context).colorScheme.background),
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