import 'package:fit_app/pages/userCreation/widgets/email_textfield.dart';
import 'package:fit_app/pages/userCreation/widgets/send_button.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  //text editing controllers
  final emailController = TextEditingController();

  //send email method
  void sendEmail() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(255, 249, 240, 1),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            //forgot password
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Color.fromRGBO(8, 31, 92, 1),
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            //text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    child: Text(
                      "Please enter your registered email address to receive a reset password link.",
                      style: TextStyle(
                        color: Color.fromRGBO(112, 150, 209, 1),
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            //email textfield
            EmailTextField(controller: emailController, hintText: 'Email'),

            const SizedBox(height: 50),

            //send button
            SendButton(
              onTap: sendEmail,
            ),

            const SizedBox(height: 50),
          ],
        ));
  }
}
