import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, Color? color, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Text(
        text,
        style: const TextStyle(fontSize: 16, letterSpacing: 0.5),
      ),
      duration: const Duration(seconds: 4),
    ),
  );
}