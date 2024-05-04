import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

//Testing homedart commit 333

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
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Aligns children horizontally
                children: [
                  Flexible(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40.0),
                          child: Text("Hi, Derakkuma",
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 36,
                                  color: Color.fromRGBO(8, 31, 92, 100))),
                        ),
                        Text("Today",
                            style: GoogleFonts.lato(
                                fontWeight: FontWeight.w400,
                                fontSize: 24,
                                color: Colors.white)),
                        Text("Snday April 20",
                            style: GoogleFonts.lato(
                                fontWeight: FontWeight.w800,
                                fontSize: 24,
                                color: Color.fromRGBO(8, 31, 92, 100)))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Flexible(
                      flex: 3,
                      child: Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 16,
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(246, 245, 245, 0.922),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0)),
              ),

              alignment: Alignment.center, // Aligns child at the center
              child: Text("Hello there", style: TextStyle(color: Colors.white)),
            ),
          ),
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
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      backgroundColor: Color.fromRGBO(112, 150, 209, 1.0),
    );
  }
}
