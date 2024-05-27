import 'package:fit_app/pages/profile/profile.dart';
import 'package:fit_app/utilities/bottom_bar.dart';
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
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Center(
              child: TopBar(),
            ),
          ),
          HomeContent(),
        ],
      ),
      // bottomNavigationBar: MyBottomNavigationBar(
      //   activeIndex: 0,
      // ),
      backgroundColor: Color.fromARGB(255, 8, 31, 92),
    );
  }
}
