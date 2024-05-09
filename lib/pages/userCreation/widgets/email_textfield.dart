import 'package:flutter/material.dart';

class EmailTextField extends StatelessWidget {
  final controller; 
  final String hintText;

  const EmailTextField({
    super.key,
    required this. controller,
    required this.hintText,
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.mail,
                  size: 40,
                  color: Color.fromRGBO(8, 31, 92, 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(247, 242, 235, 1)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(8, 31, 92, 1)),
                ),
                fillColor: Color.fromRGBO(247, 242, 235, 1),
                filled: true,
                hintText: hintText,
              ),
            ),
          );
  }
}