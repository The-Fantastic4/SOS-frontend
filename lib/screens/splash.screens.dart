import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos_frontend/widgets/colors.widgets.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<String?> _getSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('firstName');
  }

  Future<void> _navigate() async {
    String? result = await _getSharedPreferences();

    Future.delayed(const Duration(seconds: 3), () {
      if (result != null) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, 'dashboard', arguments: {
          "firstname": result,
        });
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, 'register');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Center(
          child: Image.asset('assets/splash.png'),
        ),
      ),
    );
  }
}
