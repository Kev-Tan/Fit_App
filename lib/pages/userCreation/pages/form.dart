import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_app/pages/userCreation/pages/Form%20Questions/Confirmation.dart';
import 'package:fit_app/pages/userCreation/pages/Form%20Questions/Question1.dart';
import 'package:fit_app/pages/userCreation/pages/Form%20Questions/Question2.dart';
import 'package:fit_app/pages/userCreation/pages/Form%20Questions/Question3.dart';
import 'package:fit_app/pages/userCreation/pages/Form%20Questions/Question4.dart';
import 'package:fit_app/pages/userCreation/pages/Form%20Questions/Question5.dart';
import 'package:fit_app/pages/userCreation/pages/Form%20Questions/Question6.dart';
import 'package:fit_app/pages/userCreation/pages/Form%20Questions/Question7.dart';
import 'package:fit_app/pages/userCreation/pages/Form%20Questions/Question8.dart';
import 'package:fit_app/pages/userCreation/pages/Form%20Questions/Question9.dart';
import 'package:fit_app/pages/userCreation/pages/Form%20Questions/Question10.dart';
import 'package:fit_app/pages/userCreation/pages/Form%20Questions/Question11.dart';
import 'package:fit_app/pages/userCreation/pages/Form%20Questions/Question12.dart';
import 'package:fit_app/pages/userCreation/pages/Form%20Questions/Question13.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FormPage extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final String UID;

  const FormPage({
    Key? key,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required this.UID,
  }) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  int _currentPageIndex = 0;
  final PageController _controller = PageController();
  String? _selectedGender;
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _neckController = TextEditingController();
  final TextEditingController _waistController = TextEditingController();
  final TextEditingController _hipController = TextEditingController();
  String? _selectedGoal;
  String? _selectedLevel;
  String? _selectedFrequency;
  String? _selectedDuration;
  String? _selectedTime;

  Future<void> addUserDetails(
      String username,
      String email,
      String gender,
      int age,
      int height,
      int weight,
      int neck,
      int waist,
      int hip,
      String goal,
      String level,
      String frequency,
      String duration,
      String time) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(widget.UID).set({
        'username': username,
        'email': email,
        'gender': gender,
        'age': age,
        'height': height,
        'weight': weight,
        'neck': neck,
        'waist': waist,
        'hips': hip,
        'goal': goal,
        'level': level,
        'frequency': frequency,
        'duration': duration,
        'time': time,
      });
    } catch (error) {
      print('Error adding user details: $error');
    }
  }

  void handleConfirmation() async {
    final username = widget.usernameController.text;
    final email = widget.emailController.text;
    final gender = _selectedGender;
    final age = int.tryParse(_ageController.text);
    final height = int.tryParse(_heightController.text);
    final weight = int.tryParse(_weightController.text);
    final neck = int.tryParse(_neckController.text);
    final waist = int.tryParse(_waistController.text);
    final hip = int.tryParse(_hipController.text);
    final goal = _selectedGoal;
    final level = _selectedLevel;
    final frequency = _selectedFrequency;
    final duration = _selectedDuration;
    final time = _selectedTime;

    if (username.isNotEmpty &&
        email.isNotEmpty &&
        gender != null &&
        age != null &&
        height != null &&
        weight != null &&
        neck != null &&
        waist != null &&
        (gender == 'Female' ? hip != null : true) &&
        goal != null &&
        level != null &&
        frequency != null &&
        duration != null &&
        time != null) {
      await addUserDetails(username, email, gender, age, height, weight, neck, waist, hip ?? 0, goal, level, frequency, duration, time);

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: widget.emailController.text,
          password: widget.passwordController.text,
        );
        Navigator.pop(context);
      } catch (error) {
        print('Error signing in: $error');
        // Handle sign-in error
      }
    } else {
      // Handle invalid input
      print('Invalid input');
    }
  }

  List<Widget> getQuestionsArr() {
    List<Widget> questions = [
      QuestionOne(
        onGenderSelected: (gender) {
          setState(() {
            _selectedGender = gender;
          });
        },
        selectedGender: _selectedGender,
      ),
      QuestionTwo(controller: _ageController),
      QuestionThree(controller: _heightController),
      QuestionFour(controller: _weightController),
      QuestionFive(
        controller: _neckController,
        onSkip: () {
          _controller.jumpToPage(8);
        },
      ),
    ];

    if (_selectedGender == 'Female') {
      questions.add(QuestionSix(
        controller: _waistController,
        onSkip: () {
          _controller.jumpToPage(8);
        },
      ));
      questions.add(QuestionSeven(
        controller: _hipController,
        onSkip: () {
          _controller.jumpToPage(8);
        },
      ));
    } else {
      questions.add(QuestionSix(
        controller: _waistController,
        onSkip: () {
          _controller.jumpToPage(8);
        },
      ));
    }

    questions.add(QuestionEight(
      ageController: _ageController,
      heightController: _heightController,
      weightController: _weightController,
      neckController: _neckController,
      waistController: _waistController,
      hipController: _hipController,
      genderController: TextEditingController(text: _selectedGender),
    ));

    questions.addAll([
      QuestionNine(
        onGoalSelected: (goal) {
          setState(() {
            _selectedGoal = goal;
          });
        },
        selectedGoal: _selectedGoal,
      ),
      QuestionTen(
        onLevelSelected: (level) {
          setState(() {
            _selectedLevel = level;
          });
        },
        selectedLevel: _selectedLevel,
      ),
      QuestionEleven(
        onFrequencySelected: (frequency) {
          setState(() {
            _selectedFrequency = frequency;
          });
        },
        selectedFrequency: _selectedFrequency,
      ),
      QuestionTwelve(
        onDurationSelected: (duration) {
          setState(() {
            _selectedDuration = duration;
          });
        },
        selectedDuration: _selectedDuration,
      ),
      QuestionThirteen(
        onTimeSelected: (time) {
          setState(() {
            _selectedTime = time;
          });
        },
        selectedTime: _selectedTime,
      ),
      ConfirmationPage(
        onPressed: handleConfirmation,
      ),
    ]);

    return questions;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final questionsArr = getQuestionsArr();

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
                    color: Color.fromRGBO(8, 31, 92, 1),
                  ),
                ),
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: SmoothPageIndicator(
                  controller: _controller,
                  count: questionsArr.length,
                  effect: WormEffect(
                    dotColor: Color.fromRGBO(186, 214, 235, 1),
                    activeDotColor: Color.fromRGBO(8, 31, 92, 1),
                    dotHeight: 12.0,
                    dotWidth: 12.0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
