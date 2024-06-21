import 'package:flutter/material.dart';

class WorkoutHomePage extends StatelessWidget {
  const WorkoutHomePage({Key? key}) : super(key: key);

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
          margin: EdgeInsets.only(top: 40), // Margin from the top
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
              Container(
                width: containerWidth,
                margin: EdgeInsets.only(top: 30), // Margin from the top
                padding: EdgeInsets.all(100),
                decoration: BoxDecoration(
                  color: Color(0xFF081F5C), // Background color
                  borderRadius:
                      BorderRadius.circular(15), // Curved border radius
                ),
              ),
              Container(
                width: containerWidth,
                margin: EdgeInsets.only(top: 15), // Margin from the top
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white, // Background color
                  borderRadius:
                      BorderRadius.circular(15), // Curved border radius
                  border: Border.all(
                    color: Colors.black, // Border color
                    width: 2,
                  ),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CategoryItem(label: "Back", iconPath: "assets/back.png"),
                      CategoryItem(
                          label: "Cardio", iconPath: "assets/arms.png"),
                      CategoryItem(label: "Chest", iconPath: "assets/legs.png"),
                      CategoryItem(
                          label: "Lower Arms", iconPath: "assets/neck.png"),
                      CategoryItem(
                          label: "Lower Legs", iconPath: "assets/back.png"),
                      CategoryItem(label: "Neck", iconPath: "assets/arms.png"),
                      CategoryItem(
                          label: "Shoulders", iconPath: "assets/legs.png"),
                      CategoryItem(label: "Waist", iconPath: "assets/neck.png"),
                      CategoryItem(
                          label: "Upper Arms", iconPath: "assets/legs.png"),
                      CategoryItem(
                          label: "Upper Legs", iconPath: "assets/neck.png"),
                      // Add more items as needed
                    ],
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

class CategoryItem extends StatelessWidget {
  final String label;
  final String iconPath;

  const CategoryItem({required this.label, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6),
      padding: EdgeInsets.only(top: 25, bottom: 25),
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black, // Border color
          width: 2,
        ),
        // boxShadow: [
        //   BoxShadow(
        //     // color: Colors.grey.withOpacity(0.5),
        //     spreadRadius: 2,
        //     blurRadius: 5,
        //   ),
        // ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 4), // Adjust spacing between image and label
          Text(
            label,
            style: TextStyle(
              color: Color(0xFF081F5C),
              fontSize: 12, // Adjust font size as needed
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
