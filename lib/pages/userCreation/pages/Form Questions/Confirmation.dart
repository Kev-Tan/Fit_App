import 'package:flutter/material.dart';

class ConfirmationPage extends StatelessWidget {
  final VoidCallback onPressed;

  const ConfirmationPage({Key? key, required this.onPressed}) : super(key: key);

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
                    "COMPLETE",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily:
                          'Lato', 
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color:Color.fromARGB(255, 8, 31, 92),
                    ),
                  ),
                ),
                SizedBox(height: 30), 
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Thank you for completing your basic information!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 24, 
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 8, 31, 92),
                    )
                  )
                ),
                SizedBox(height: 30), 
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Generating workout...",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 24, 
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 8, 31, 92),
                    )
                  )
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: onPressed,
                  child: Text(
                    'Done',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(255, 249, 240, 1),
                    )
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 8, 31, 92),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
