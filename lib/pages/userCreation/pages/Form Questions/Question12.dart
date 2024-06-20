import 'package:flutter/material.dart';

class QuestionTwelve extends StatefulWidget {
  final ValueChanged<String> onDurationSelected;
  final String? selectedDuration;

  const QuestionTwelve({Key? key, required this.onDurationSelected, this.selectedDuration}) : super(key: key);

  @override
  _QuestionTwelveState createState() => _QuestionTwelveState();
}

class _QuestionTwelveState extends State<QuestionTwelve> {
  String? _selectedDuration;

  @override 
  void initState() {
    super.initState();
    _selectedDuration = widget.selectedDuration;
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
                    "How long do you want each workout to be?",
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
                  value: _selectedDuration,
                  items: ['30 minutes', '60 minutes', '120 minutes'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedDuration = newValue;
                    });
                    widget.onDurationSelected(newValue!);
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 8, 31, 92)),
                    ),
                    labelText: 'Select your workout duration',
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
