import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SigninButton extends StatelessWidget {
  
  final Function()? onTap; 

  const SigninButton({
    super.key, 
    required this.onTap
    }); 

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 100.0),
        decoration: BoxDecoration(
          color: Color.fromRGBO(8, 31, 92, 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            "SIGN IN",
            style: TextStyle(
              color: Color.fromRGBO(255, 249, 240, 1),
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          )
        )
      )
    );
  }
}
