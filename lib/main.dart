import 'package:flutter/material.dart';
import 'package:sos_frontend/screens/register.screens.dart';
import 'package:sos_frontend/screens/splash.screens.dart';

void main() async {
  runApp(MaterialApp(initialRoute: 'register', routes: {
    'splash': (context) => const Splash(),
    'register': (context) => const Register()
  }));
}
