import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TopBar extends StatefulWidget {
  const TopBar({super.key});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final dateFormatter = DateFormat('yyyy-MM-dd');
    final formattedDate = dateFormatter.format(now);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
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
              Text(formattedDate,
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
    );
  }
}
