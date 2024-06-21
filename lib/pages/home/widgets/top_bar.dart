import 'package:fit_app/models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final dateFormatter = DateFormat('yyyy-MM-dd');
    final formattedDate = dateFormatter.format(now);
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth * 0.8; // 80% of the screen width

    return Container(
      color: Color.fromARGB(
          255, 8, 31, 92), // Set your desired background color here
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: containerWidth,
          margin: EdgeInsets.only(top: 40), // Margin from the top
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                // Use Expanded instead of Flexible for proper layout
                flex: 8,
                child: Consumer<UserProvider>(
                  builder: (context, userProvider, child) {
                    String username = userProvider.user?.username ?? "guest";
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi, $username!",
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                            fontSize: 36,
                            color: Colors.white,
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
                    );
                  },
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
                  child: Center(
                    child: Image.asset(
                      'lib/assets/bell.png', // Replace with your image path
                      width: 45, // Adjust width as needed
                      height: 45, // Adjust height as needed
                      color: Color(0xFF081F5C), // Custom icon color
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
