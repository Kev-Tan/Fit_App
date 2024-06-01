import 'package:fit_app/pages/userCreation/pages/Form%20Questions/Confirmation.dart';
import 'package:fit_app/pages/userCreation/pages/Form%20Questions/Question2.dart';
import 'package:fit_app/pages/userCreation/pages/Form%20Questions/Question3.dart';
import 'package:fit_app/pages/userCreation/pages/Form%20Questions/Question4.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  // PageController to control the PageView

  // Variable to track the current page index
  int _currentPageIndex = 0;

  final PageController _controller = PageController();
  final TextEditingController _AgeController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  void infoPrinter() {
    print("Age is ${_AgeController.text}");
    print("Height is ${_heightController.text}");
    print("Height is ${_weightController.text}");
  }

  @override
  Widget build(BuildContext context) {
    // Get the height and width of the screen
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final questionsArr = [
      QuestionTwo(controller: _AgeController),
      QuestionThree(controller: _heightController),
      QuestionFour(controller: _weightController),
      ConfirmationPage(
        onPressed: infoPrinter,
      ),
    ];

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Text(
                    "Step ${_currentPageIndex + 1} / ${questionsArr.length}",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 8, 31, 92))),
              ),
              SizedBox(
                  height: 0.75 * screenHeight,
                  child: PageView(
                    controller: _controller,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPageIndex = index;
                      });
                    },
                    children: questionsArr,
                  )),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: SmoothPageIndicator(
                  controller: _controller,
                  count: questionsArr.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
