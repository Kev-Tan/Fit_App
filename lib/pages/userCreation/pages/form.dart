import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_app/pages/userCreation/pages/Form%20Questions/Confirmation.dart';
import 'package:fit_app/pages/userCreation/pages/Form%20Questions/Question2.dart';
import 'package:fit_app/pages/userCreation/pages/Form%20Questions/Question3.dart';
import 'package:fit_app/pages/userCreation/pages/Form%20Questions/Question4.dart';
import 'package:fit_app/pages/userCreation/pages/Form%20Questions/Question5.dart';
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
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _neckController = TextEditingController();

  Future<void> addUserDetails(int age, int height, int weight, String username,
      String email, int neck) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(widget.UID).set({
        'username': username,
        'email': email,
        'age': age,
        'height': height,
        'weight': weight,
        'neck': neck,
      });
    } catch (error) {
      print('Error adding user details: $error');
    }
  }

  void handleConfirmation() async {
    final age = int.tryParse(_ageController.text);
    final height = int.tryParse(_heightController.text);
    final weight = int.tryParse(_weightController.text);
    final neck = int.tryParse(_neckController.text);
    final username = widget.usernameController.text;
    final email = widget.emailController.text;

    if (age != null &&
        height != null &&
        weight != null &&
        username.isNotEmpty &&
        email.isNotEmpty &&
        neck != null) {
      await addUserDetails(age, height, weight, username, email, neck);

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

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final questionsArr = [
      QuestionTwo(controller: _ageController),
      QuestionThree(controller: _heightController),
      QuestionFour(controller: _weightController),
      QuestionFive(controller: _neckController),
      ConfirmationPage(
        onPressed: handleConfirmation,
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
                    color: Color.fromARGB(255, 8, 31, 92),
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
