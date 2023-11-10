// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos_frontend/api_calls/location.api_calls.dart';
import 'package:sos_frontend/api_calls/register.api_calls.dart';
import 'package:sos_frontend/widgets/loader.widgets.dart';
import 'package:sos_frontend/widgets/register.widgets.dart';
import 'package:sos_frontend/widgets/snackbar.widgets.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  bool _isFirstnameFieldEmpty = true;
  bool _isSurnameFieldEmpty = true;
  bool _isContactFieldEmpty = true;

  @override
  void initState() {
    super.initState();

    handleLocationPermissions();
    firstNameController.addListener(_checkTextfieldEmpty);
    surnameController.addListener(_checkTextfieldEmpty);
    contactController.addListener(_checkTextfieldEmpty);
  }

  void _checkTextfieldEmpty() {
    setState(() {
      _isFirstnameFieldEmpty = firstNameController.text.isEmpty;
      _isSurnameFieldEmpty = surnameController.text.isEmpty;
      _isContactFieldEmpty = contactController.text.isEmpty;
    });
  }

  Future<void> saveValuesToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('firstName', firstNameController.text);
    await prefs.setString('surname', surnameController.text);
    await prefs.setString('contact', contactController.text);
  }

  // @override
  // void dispose() {
  //   firstNameController.dispose();
  //   surnameController.dispose();
  //   contactController.dispose();
  //   super.dispose();
  // }

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
                    controller: firstNameController,
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
                    controller: surnameController,
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
                    controller: contactController,
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          minimumSize: const Size(150, 60),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () async {
                        if (_isFirstnameFieldEmpty ||
                            _isSurnameFieldEmpty ||
                            _isContactFieldEmpty) {
                          showSnackBar(context, Colors.red,
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

    saveValuesToSharedPreferences();

    final res = await register(firstNameController.text, surnameController.text,
        contactController.text);

    if (res != null) {
      Navigator.of(context).pop();
      Navigator.pushNamed(context, 'dashboard', arguments: {
        "firstname": firstNameController.text,
      });
    }
  }
}
