import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';

Future<void> handleLocationPermissions() async {
  bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();

  if (!isLocationEnabled) {
    return Future.error("error");
  }

  LocationPermission permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error("Then what's the point of the app");
  }
}

Future<Position> getLiveLocation() async {
  return await Geolocator.getCurrentPosition();
}

Future<void> sendLiveLocation() async {
  Position liveLocation = await getLiveLocation();
  Dio dio = Dio();

  try {
    final data = {
      "city": "Takoradi",
      "name_of_location": "",
      "longitude": liveLocation.longitude,
      "lattitude": liveLocation.latitude
    };

    final res =
        await dio.post('https://sos-service.onrender.com/location', data: data);
    print(res);
  } catch (e) {
    throw Exception(e);
  }
}
