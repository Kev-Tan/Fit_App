import 'package:fit_app/pages/userCreation/widgets/email_textfield.dart';
import 'package:fit_app/pages/userCreation/widgets/password_textfield.dart';
import 'package:fit_app/pages/userCreation/widgets/signup_button.dart';
import 'package:fit_app/pages/userCreation/widgets/username_textfield.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  //text editing controllers
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //sign user in method
  void signUserUp() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(255, 249, 240, 1),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),

            // back button
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

            //sign up
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

            //username textfield
            UsernameTextField(
                controller: usernameController, hintText: 'Username'),

            const SizedBox(height: 10),

            //email textfield
            EmailTextField(controller: emailController, hintText: 'Email'),

            const SizedBox(height: 10),

            //password textfield
            PasswordTextField(
                controller: passwordController, hintText: 'Password'),

            const SizedBox(height: 10),

            //reconfirm password
            PasswordTextField(
                controller: passwordController, hintText: 'Re-enter Password'),

            const SizedBox(height: 50),

            //sign up button
            SignupButton(
              onTap: signUserUp,
            ),

            const SizedBox(height: 50),
          ],
        ));
  }
}
