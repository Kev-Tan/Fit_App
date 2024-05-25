import 'package:fit_app/pages/chat/chat.dart';
import 'package:fit_app/pages/home/home.dart';
import 'package:fit_app/pages/profile/profile.dart';
import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatefulWidget {
  final int activeIndex;

  const MyBottomNavigationBar({Key? key, required this.activeIndex})
      : super(key: key);

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  late int _selectedIndex; // Initialize as late int

  @override
  void initState() {
    super.initState();
    _selectedIndex =
        widget.activeIndex; // Initialize _selectedIndex with activeIndex
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.fitness_center),
          label: 'Workout',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      onTap: (index) {
        setState(() {});
        if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Home(),
            ),
          );
        } else if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(),
            ),
          );
        } else if (index == 3) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfilePage(),
            ),
          );
        }
      },
      currentIndex: _selectedIndex, // Highlight the selected index
      selectedItemColor: Colors.amber[800],
      backgroundColor: Colors.white,
    );
  }
}
