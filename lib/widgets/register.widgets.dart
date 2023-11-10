import 'package:flutter/material.dart';

class RegisterFields extends StatelessWidget {
  final String hintText;
  final Widget prefixIcon;
  final TextEditingController controller;

  const RegisterFields(
      {super.key,
      required this.hintText,
      required this.prefixIcon,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 60,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 18, 0, 0),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
                prefixIcon: prefixIcon,
                hintText: hintText,),
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

Color? backgroundColor = Color.fromARGB(255, 252, 231, 231);
