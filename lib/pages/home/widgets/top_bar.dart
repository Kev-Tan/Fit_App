import 'package:fit_app/models/user_provider.dart';
import 'package:fit_app/theme/theme.dart';
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
      color: Theme.of(context).colorScheme.primary,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: containerWidth,
          margin: EdgeInsets.only(top: 40), // Margin from the top
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
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
                            color: Theme.of(context).colorScheme.background,
                          ),
                        ),
                        Text(
                          "Today",
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w400,
                            fontSize: 24,
                            color: Theme.of(context).colorScheme.background,
                          ),
                        ),
                        Text(
                          formattedDate,
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w800,
                            fontSize: 24,
                            color: Theme.of(context).colorScheme.background,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Consumer<ThemeProvider>(
                  builder: (context, themeProvider, child) {
                    return Switch(
                      value: themeProvider.isDarkMode,
                      onChanged: (value) {
                        themeProvider.toggleTheme();
                      },
                      activeColor: Theme.of(context).colorScheme.background,
                      inactiveThumbColor: Theme.of(context).colorScheme.background,
                      inactiveTrackColor: Theme.of(context).colorScheme.background.withOpacity(0.5),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
