import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_app/pages/home/home.dart';
import 'package:fit_app/pages/main_screen.dart';
import 'package:fit_app/pages/userCreation/pages/form.dart';
import 'package:fit_app/pages/userCreation/widgets/email_textfield.dart';
import 'package:fit_app/pages/userCreation/widgets/password_textfield.dart';
import 'package:fit_app/pages/userCreation/widgets/signup_button.dart';
import 'package:fit_app/pages/userCreation/widgets/username_textfield.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // Text editing controllers
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final reconfirmPasswordController = TextEditingController();

  var userID;

  // Method to show loading dialog
  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  // Method to close loading dialog
  void _closeLoadingDialog() {
    Navigator.of(context).pop();
  }

  // Sign user up method
  void signUserUp() async {
    print("Signup tapped");
    try {
      _showLoadingDialog();

      // Check if passwords are the same when reconfirming
      if (passwordController.text == reconfirmPasswordController.text) {
        // Create user with email and password
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // Get the current user's UID
        User? firebaseUser = FirebaseAuth.instance.currentUser;
        if (firebaseUser != null) {
          userID = firebaseUser.uid;

          // Immediately sign the user out
          await FirebaseAuth.instance.signOut();

          _closeLoadingDialog();

          // Navigate to the FormPage
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => FormPage(
                usernameController: usernameController,
                emailController: emailController,
                passwordController: passwordController,
                UID: userID,
              ),
            ),
          );
        } else {
          _closeLoadingDialog();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to get user information'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        _closeLoadingDialog();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Passwords do not match'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      _closeLoadingDialog();
      print('Error signing up: $error');
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to sign up: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 249, 240, 1),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),

              // Back button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Color.fromRGBO(8, 31, 92, 1),
                        size: 25.0,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),

              // Sign up
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Color.fromRGBO(8, 31, 92, 1),
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              // Username textfield
              UsernameTextField(
                controller: usernameController,
                hintText: 'Username',
              ),
              const SizedBox(height: 10),

              // Email textfield
              EmailTextField(
                controller: emailController,
                hintText: 'Email',
              ),
              const SizedBox(height: 10),

              // Password textfield
              PasswordTextField(
                controller: passwordController,
                hintText: 'Password',
              ),
              const SizedBox(height: 10),

              // Reconfirm password
              PasswordTextField(
                controller: reconfirmPasswordController,
                hintText: 'Re-enter Password',
              ),
              const SizedBox(height: 50),

              // Sign up button
              SignupButton(
                onTap: signUserUp,
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
