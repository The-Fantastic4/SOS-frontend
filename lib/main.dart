import 'package:flutter/material.dart';
import 'package:sos_frontend/screens/dashboard.screens.dart';
import 'package:sos_frontend/screens/register.screens.dart';
import 'package:sos_frontend/screens/splash.screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    initialRoute: 'splash',
    routes: {
      'splash': (context) => const Splash(),
      'register': (context) => const Register(),
      'dashboard': (context) => const Dashboard()
    },
    debugShowCheckedModeBanner: false,
  ));
}
