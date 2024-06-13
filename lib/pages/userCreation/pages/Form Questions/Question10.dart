import 'package:flutter/material.dart';

class QuestionTen extends StatefulWidget {
  final ValueChanged<String> onLevelSelected;

  const QuestionTen({Key? key, required this.onLevelSelected}) : super(key: key);

  @override
  _QuestionTenState createState() => _QuestionTenState();
}

class _QuestionTenState extends State<QuestionTen> {
  String? _selectedLevel;

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
                    "What is your fitness level?",
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
                  value: _selectedLevel,
                  items: ['Beginner', 'Intermediate', 'Advanced'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedLevel = newValue;
                    });
                    widget.onLevelSelected(newValue!);
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 8, 31, 92)),
                    ),
                    labelText: 'Select your fitness level',
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
