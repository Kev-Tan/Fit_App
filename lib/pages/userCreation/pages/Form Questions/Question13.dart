import 'package:flutter/material.dart';

class QuestionThirteen extends StatefulWidget {
  final ValueChanged<String> onTimeSelected;
  final String? selectedTime;

  const QuestionThirteen({Key? key, required this.onTimeSelected, this.selectedTime}) : super(key: key);

  @override
  _QuestionThirteenState createState() => _QuestionThirteenState();
}

class _QuestionThirteenState extends State<QuestionThirteen> {
  String? _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.selectedTime;
  }

  Future<void> _selectTime(BuildContext context) async {
    final initialTime = _selectedTime != null
        ? TimeOfDay(
            hour: int.parse(_selectedTime!.split(":")[0]),
            minute: int.parse(_selectedTime!.split(":")[1]),
          )
        : TimeOfDay.now();
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked.format(context);
      });
      widget.onTimeSelected(_selectedTime!);
    }
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
                    "What time do you want to workout?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 26,
                      color: Color.fromARGB(255, 8, 31, 92),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () => _selectTime(context),
                  child: Text(
                    _selectedTime == null ? 'Select Time' : _selectedTime!,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 8, 31, 92),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
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
