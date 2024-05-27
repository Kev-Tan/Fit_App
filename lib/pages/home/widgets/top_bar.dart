import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//new may 10 update

class TopBar extends StatefulWidget {
  const TopBar({Key? key});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  final user = FirebaseAuth.instance.currentUser!;

  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final dateFormatter = DateFormat('yyyy-MM-dd');
    final formattedDate = dateFormatter.format(now);
    return Container(
      color: Color.fromARGB(
          255, 8, 31, 92), // Set your desired background color here
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Text("Hi, Kappurio!",
                      style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          fontSize: 36,
                          color: Colors.white)),
                ),
                Text("Today",
                    style: GoogleFonts.lato(
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                        color: Colors.white)),
                Text(formattedDate,
                    style: GoogleFonts.lato(
                        fontWeight: FontWeight.w800,
                        fontSize: 24,
                        color: Colors.white))
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
    );
  }
}
