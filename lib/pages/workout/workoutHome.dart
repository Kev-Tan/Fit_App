import 'package:flutter/material.dart';

class WorkoutPage extends StatelessWidget {
  const WorkoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth * 0.9; // 90% of the screen width

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Workout Page'),
      // ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: containerWidth,
          margin: EdgeInsets.only(top: 70), // Margin from the top
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello, #username#",
                        style: TextStyle(
                          color: Color(0xFF081F5C), // Custom color
                          fontSize: 12, // Adjust font size as needed
                          fontWeight: FontWeight.normal, // Normal weight
                          fontFamily: 'Lato', // Font family
                        ),
                      ),
                      Text(
                        "Start your workout",
                        style: TextStyle(
                          color: Color(0xFF081F5C), // Custom color
                          fontSize: 16, // Adjust font size as needed
                          fontWeight: FontWeight.bold, // Bold text
                          fontFamily: 'Lato', // Font family
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Icon(
                    Icons.notifications,
                    size: 45, // Adjust icon size as needed
                    color: Color(0xFF081F5C), // Custom icon color
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
