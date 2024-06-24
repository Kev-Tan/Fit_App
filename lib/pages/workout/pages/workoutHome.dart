import 'package:fit_app/pages/workout/pages/ExercisePage.dart';
import 'package:fit_app/pages/workout/pages/category.dart';
import 'package:fit_app/pages/workout/pages/favorites.dart';
import 'package:flutter/material.dart';
import 'package:fit_app/models/user_provider.dart';
import 'package:fit_app/pages/workout/pages/workout.dart';
import 'package:fit_app/pages/workout/pages/library.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'new_page.dart'; // Import the new chat page

class WorkoutHomePage extends StatelessWidget {
  const WorkoutHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final userModel = userProvider.user; // Access the user model instance

        double screenWidth = MediaQuery.of(context).size.width;
        double containerWidth = screenWidth * 0.9; // 90% of the screen width
        final username = userModel?.username ?? "Not A Member";

        return Scaffold(
          body: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Container(
                width: containerWidth,
                margin: EdgeInsets.only(top: 40, bottom: 40),
                padding:
                    EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 80),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello, $username",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Lato',
                              ),
                            ),
                            Text(
                              "Start your workout",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Lato',
                              ),
                            ),
                          ],
                        ),
                        // Spacer(),
                        // Icon(
                        //   Icons.notifications,
                        //   size: 45,
                        //   color: Theme.of(context).colorScheme.primary,
                        // ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatPage(
                                  userProvider:
                                      userProvider)), // Navigate to the new chat page
                        );
                      },
                      child: Container(
                        width: containerWidth,
                        margin: EdgeInsets.only(top: 30),
                        padding: EdgeInsets.all(85),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Exercise Library",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lato',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: containerWidth,
                      margin: EdgeInsets.only(top: 15),
                      padding: EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2,
                        ),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            CategoryItem(
                                label: "Back", 
                                iconPath: "lib/assets/back.png"),
                            CategoryItem(
                                label: "Cardio", 
                                iconPath: "lib/assets/cardio.png"),
                            CategoryItem(
                                label: "Chest", 
                                iconPath: "lib/assets/chest.png"),
                            CategoryItem(
                                label: "Lower Arms",
                                iconPath: "lib/assets/lower_arms.png"),
                            CategoryItem(
                                label: "Lower Legs",
                                iconPath: "lib/assets/lower_legs.png"),
                            CategoryItem(
                                label: "Neck", 
                                iconPath: "lib/assets/neck.png"),
                            CategoryItem(
                                label: "Shoulders",
                                iconPath: "lib/assets/shoulders.png"),
                            CategoryItem(
                                label: "Waist", 
                                iconPath: "lib/assets/waist.png"),
                            CategoryItem(
                                label: "Upper Arms",
                                iconPath: "lib/assets/upper_arms.png"),
                            CategoryItem(
                                label: "Upper Legs",
                                iconPath: "lib/assets/upper_legs.png"),
                          ],
                        ),
                      ), 
                    ),
                    Container(
                      width: containerWidth,
                      margin: EdgeInsets.only(top: 30),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                // Navigate to ChatPage when pressed
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ExercisePage(),
                                    ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                height: 170,
                                padding: EdgeInsets.all(12),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    "Search",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Lato',
                                      fontWeight: FontWeight.normal,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background, // Text color
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FavoritesPage(
                                          userProvider: userProvider)),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                height: 170,
                                padding:
                                    EdgeInsets.all(12), // Add padding for text
                                child: Align(
                                  alignment: Alignment
                                      .bottomLeft, // Align text to bottom left corner
                                  child: Text(
                                    "Favorites",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Lato',
                                      fontWeight: FontWeight.normal,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background, // Text color
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // void _showNotification() {
  //   // Implement your notification logic here
  //   // Example: NotificationService().showNotification(id: 0, title: "Sample title", body: "It works!");
  // }
}

class CategoryItem extends StatelessWidget {
  final String label;
  final String iconPath;

  const CategoryItem({required this.label, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the desired page when the category item is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CategoryPage(userProvider: UserProvider(), category: label),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6),
        padding: EdgeInsets.only(top: 25, bottom: 25),//.all(8)
        width: 100,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              iconPath,
              height: 50,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
