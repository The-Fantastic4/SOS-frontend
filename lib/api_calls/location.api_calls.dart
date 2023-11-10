import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sos_frontend/widgets/snackbar.widgets.dart';

Future<bool> handleLocationPermission() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();

  if (!serviceEnabled) {
    // showSnackBar(context, color, text);
    return false;
  }

  permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      // showSnackBar(context, color, text);
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    // showSnackBar(context, color, text);
    return false;
  }
  return true;
}

getLiveLocation() async {
  final hasPermission = await handleLocationPermission();

  if (!hasPermission) return;

  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  
}
