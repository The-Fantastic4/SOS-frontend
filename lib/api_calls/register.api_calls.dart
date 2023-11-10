import 'package:dio/dio.dart';

register(String firstName, String lastName, String phoneNumber) async {
  Dio dio = Dio();
  
  try {
    final data = {
      "firstName": firstName,
      "lastName": lastName,
      "phone_number": phoneNumber
    };
    
    final response = await dio.post(
      'https://sos-service.onrender.com/register',
      data: data);

    if (response.statusCode == 200) {
      return response.data;
    }
  } catch (e) {
    throw Exception(e);
  }
}
