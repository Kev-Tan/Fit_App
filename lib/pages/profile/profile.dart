import 'package:fit_app/utilities/bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    double containerWidth = 90.0; // Width of the green container
    double containerHeight = 250.0; // Height of the green container

    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 230,
            color: Color.fromRGBO(112, 150, 209, 1),
          ),
          Positioned(
            top: 100,
            left: (MediaQuery.of(context).size.width - containerWidth * 4) /
                2, // Center horizontally
            child: Container(
              width: containerWidth * 4, // Adjusted width for centering
              height: containerHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        activeIndex: 3,
      ),
    );
  }
}
