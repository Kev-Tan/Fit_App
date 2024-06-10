import 'package:flutter/material.dart';
import 'dart:math';

class QuestionEight extends StatefulWidget {
  final TextEditingController genderController;
  final TextEditingController ageController;
  final TextEditingController heightController;
  final TextEditingController weightController;
  final TextEditingController neckController;
  final TextEditingController waistController;
  final TextEditingController hipController;

  const QuestionEight({
    Key? key,
    required this.genderController,
    required this.ageController,
    required this.heightController,
    required this.weightController,
    required this.neckController,
    required this.waistController,
    required this.hipController,
  }) : super(key: key);

  @override
  _QuestionEightState createState() => _QuestionEightState();
}

class _QuestionEightState extends State<QuestionEight> {
  double _bodyFatPercentage = 0.0;

  void calculateBodyFatPercentage() {
    final gender = widget.genderController.text;
    final height = double.tryParse(widget.heightController.text) ?? 0.0;
    final neck = double.tryParse(widget.neckController.text) ?? 0.0;
    final waist = double.tryParse(widget.waistController.text) ?? 0.0;
    final hip = double.tryParse(widget.hipController.text) ?? 0.0;

    if (gender.isEmpty || height == 0.0 || neck == 0.0 || waist == 0.0 || (gender == 'Female' && hip == 0.0)) {
      return; // Return if any required field is missing
    }

    double bodyFatPercentage;

    if (gender == 'Male') {
      bodyFatPercentage = 495 / (1.0324 - 0.19077 * log(waist - neck) + 0.15456 * log(height)) - 450;
    } else if (gender == 'Female') {
      bodyFatPercentage = 495 / (1.29579 - 0.35004 * log(waist + hip - neck) + 0.22100 * log(height)) - 450;
    } else {
      return; // Return if gender is invalid
    }

    setState(() {
      _bodyFatPercentage = bodyFatPercentage;
    });
  }

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
            width: 2,
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
                    "Your Body Fat Percentage is:",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Image.asset('lib/assets/question8_image.png'),
                SizedBox(height: 50),
                Container(
                  padding: const EdgeInsets.all(25),
                  margin: const EdgeInsets.symmetric(horizontal: 25.0),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(8, 31, 92, 1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      _bodyFatPercentage == 0.0
                          ? 'Body Fat Percentage'
                          : '${_bodyFatPercentage.toStringAsFixed(2)}%',
                      style: TextStyle(
                        color: Color.fromRGBO(247, 242, 235, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: calculateBodyFatPercentage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(8, 31, 92, 1),
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Calculate",
                    style: TextStyle(
                      color: Color.fromRGBO(247, 242, 235, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}