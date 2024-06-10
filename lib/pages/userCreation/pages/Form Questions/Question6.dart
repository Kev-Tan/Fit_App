import 'package:flutter/material.dart';

class QuestionSix extends StatelessWidget {
  final TextEditingController controller;

  const QuestionSix({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Color.fromARGB(255, 8, 31, 92),
            width: 2, // Adjust the border width as needed
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "What is your waist circumference?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily:
                          'Lato', // Ensure you have added the Lato font to your project
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: 50), // Add some spacing
                Image.asset('lib/assets/question6_image.png'),
                SizedBox(height: 50), // Add some spacing

                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(
                              255, 8, 31, 92)), // Change border color here
                    ),
                    labelText: 'Enter your waist circumference',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
