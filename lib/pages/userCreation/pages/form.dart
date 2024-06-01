import 'package:fit_app/pages/userCreation/pages/Form%20Questions/Question1.dart';
import 'package:fit_app/pages/userCreation/pages/Form%20Questions/Question2.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  // PageController to control the PageView
  final PageController _controller = PageController();

  // Variable to track the current page index
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Get the height and width of the screen
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final questionsArr = [
      QuestionTwo(),
      QuestionThree(),
    ];

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Step ${_currentPageIndex + 1} / ${questionsArr.length}",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 8, 31, 92))),
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
            SmoothPageIndicator(
              controller: _controller,
              count: questionsArr.length,
            )
          ],
        ),
      ),
    );
  }
}
