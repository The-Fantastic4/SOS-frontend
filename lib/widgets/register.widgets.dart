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
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          prefix: prefixIcon,
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
      style: const TextStyle(
        fontSize: 16,
      ),
    );
  }
}
