import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignupButton extends StatelessWidget {
  final Function()? onTap;

  const SignupButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(horizontal: 25.0),
            decoration: BoxDecoration(
              color: Color.fromRGBO(8, 31, 92, 1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
                child: Text(
              "SIGN UP",
              style: TextStyle(
                color: Color.fromRGBO(255, 249, 240, 1),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ))));
  }
}
