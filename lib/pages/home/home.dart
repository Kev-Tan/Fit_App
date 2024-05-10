import 'package:fit_app/pages/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:fit_app/pages/home/widgets/home_content.dart';
import 'package:fit_app/pages/home/widgets/top_bar.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Center(
              child: TopBar(),
            ),
          ),
          HomeContent(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
          if (index == 3) {
            // Index 3 corresponds to the "Profile" item
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ProfilePage()), // Navigate to the profile page
            );
          }
        },
      ),
      backgroundColor: Color.fromRGBO(112, 150, 209, 1.0),
    );
  }
}
