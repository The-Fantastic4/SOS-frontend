// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos_frontend/api_calls/location.api_calls.dart';
import 'package:sos_frontend/api_calls/register.api_calls.dart';
import 'package:sos_frontend/widgets/colors.widgets.dart';
import 'package:sos_frontend/widgets/loader.widgets.dart';
import 'package:sos_frontend/widgets/register.widgets.dart';
import 'package:sos_frontend/widgets/snackbar.widgets.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  bool _isFirstnameFieldEmpty = true;
  bool _isSurnameFieldEmpty = true;
  bool _isContactFieldEmpty = true;

  @override
  void initState() {
    super.initState();

    handleLocationPermissions();
    _firstNameController.addListener(_checkTextfieldEmpty);
    _surnameController.addListener(_checkTextfieldEmpty);
    _contactController.addListener(_checkTextfieldEmpty);
  }

  void _checkTextfieldEmpty() {
    setState(() {
      _isFirstnameFieldEmpty = _firstNameController.text.isEmpty;
      _isSurnameFieldEmpty = _surnameController.text.isEmpty;
      _isContactFieldEmpty = _contactController.text.isEmpty;
    });
  }

  Future<void> _saveValuesToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('firstName', _firstNameController.text);
    await prefs.setString('surname', _surnameController.text);
    await prefs.setString('contact', _contactController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 90,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/welcome.png'),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Register to continue...',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  RegisterFields(
                    hintText: 'First name',
                    prefixIcon: const Icon(
                      Icons.account_circle_outlined,
                      color: Colors.black,
                    ),
                    controller: _firstNameController,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  RegisterFields(
                    hintText: 'Surname',
                    prefixIcon: const Icon(
                      Icons.account_circle_outlined,
                      color: Colors.black,
                    ),
                    controller: _surnameController,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  RegisterFields(
                    hintText: 'Contact',
                    prefixIcon: const Icon(
                      Icons.contact_phone_outlined,
                      color: Colors.black,
                    ),
                    controller: _contactController,
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          minimumSize: const Size(150, 60),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () async {
                        if (_isFirstnameFieldEmpty ||
                            _isSurnameFieldEmpty ||
                            _isContactFieldEmpty) {
                          showSnackBar(context, primaryColor,
                              "Field cannot be left empty");
                        } else {
                          _onButtonPressed();
                        }
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void _onButtonPressed() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const CustomLoadingAnimation());

    _saveValuesToSharedPreferences();

    final res = await register(_firstNameController.text,
        _surnameController.text, _contactController.text);

    if (res != DioException && res != null) {
      Navigator.of(context).pop();
      Navigator.pushReplacementNamed(context, 'dashboard', arguments: {
        "firstname": _firstNameController.text,
      });
    } else {
      Navigator.of(context).pop();
      showSnackBar(
          context, primaryColor, "Registration failed! Please try again");
    }
  }
}
