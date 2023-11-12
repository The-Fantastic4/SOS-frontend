import 'package:dio/dio.dart';

register(String firstName, String lastName, String phoneNumber) async {
  Dio dio = Dio();

  try {
    final data = {
      "firstName": firstName,
      "lastName": lastName,
      "phone_number": phoneNumber
    };

    final response = await dio.post('https://sos-service.onrender.com/register',
        options: Options(receiveTimeout: const Duration(microseconds: 5000)),
        data: data);

    if (response.statusCode == 200) {
      return response.data;
    }
  } on DioError catch (e) {
    if (e.type == DioErrorType.connectionTimeout ||
        e.type == DioErrorType.receiveTimeout) {
      return e;
    }
  }
}
