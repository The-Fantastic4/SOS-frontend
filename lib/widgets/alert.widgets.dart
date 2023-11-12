// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:sos_frontend/api_calls/location.api_calls.dart';
import 'package:sos_frontend/widgets/colors.widgets.dart';
import 'package:sos_frontend/widgets/loader.widgets.dart';
import 'package:sos_frontend/widgets/snackbar.widgets.dart';

Future<dynamic> alert(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: const Text(
              'Send emergency alert!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            content: const Text(
              'Are you sure you want to send an alert to the nearest police station?',
              style: TextStyle(fontSize: 16),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'No'),
                child: const Text(
                  'No',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () async {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const CustomLoadingAnimation());

                  final result = await sendLiveLocation();

                  if (result == 200) {
                    Navigator.of(context).pop();

                    Navigator.pop(context, 'Yes');

                    showSnackBar(
                        context, Colors.green, 'Alert sent! Help is coming');
                  } else {
                    Navigator.of(context).pop();
                    showSnackBar(context, primaryColor,
                        "Failed to alert, please try again");
                  }
                },
                child: const Text(
                  'Yes',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ));
}
