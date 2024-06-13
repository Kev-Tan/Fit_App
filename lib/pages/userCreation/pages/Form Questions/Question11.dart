import 'package:flutter/material.dart';

class QuestionEleven extends StatefulWidget {
  final ValueChanged<String> onFrequencySelected;

  const QuestionEleven({Key? key, required this.onFrequencySelected}) : super(key: key);

  @override
  _QuestionElevenState createState() => _QuestionElevenState();
}

class _QuestionElevenState extends State<QuestionEleven> {
  String? _selectedFrequency;

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
                    "How often do you want to workout?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 26,
                      color:  Color.fromARGB(255, 8, 31, 92),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 50),
                DropdownButtonFormField<String>(
                  value: _selectedFrequency,
                  items: ['1-2 times a week', '3-4 times a week', '5-6 times a week'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedFrequency = newValue;
                    });
                    widget.onFrequencySelected(newValue!);
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 8, 31, 92)),
                    ),
                    labelText: 'Select your workout frequency',
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
