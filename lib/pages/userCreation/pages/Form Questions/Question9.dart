import 'package:flutter/material.dart';

class QuestionNine extends StatefulWidget {
  final ValueChanged<String> onGoalSelected;
  final String? selectedGoal; 

  const QuestionNine({Key? key, required this.onGoalSelected, this.selectedGoal}) : super(key: key);

  @override
  _QuestionNineState createState() => _QuestionNineState();
}

class _QuestionNineState extends State<QuestionNine> {
  String? _selectedGoal;

  @override 
  void initState() {
    super.initState();
    _selectedGoal = widget.selectedGoal;
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
                    "What are your fitness goals?",
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
                  value: _selectedGoal,
                  items: ['Lose Weight', 'Gain Weight', 'Get Fit'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedGoal = newValue;
                    });
                    widget.onGoalSelected(newValue!);
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 8, 31, 92)),
                    ),
                    labelText: 'Select your fitness goals',
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
