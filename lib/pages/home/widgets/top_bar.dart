import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TopBar extends StatefulWidget {
  const TopBar({Key? key}) : super(key: key); // Correctly initialize the key

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  User? currentUser;
  var username = "guest";

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      String uid = currentUser!.uid;
      print("______________Current user's UID: $uid");
      fetchUsername(uid);
    } else {
      print("No user is currently logged in.");
    }
  }

  Future<void> fetchUsername(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userDoc.exists && username == "guest") {
        setState(() {
          username = userDoc['username'];
        });
      } else {
        print("No such document!");
      }
    } catch (e) {
      print("Error getting document: $e");
    }
  }

  @override
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
          Expanded(
            // Use Expanded instead of Flexible for proper layout
            flex: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Text(
                    "Hi, ${username}!",
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  "Today",
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                Text(
                  formattedDate,
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.w800,
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
