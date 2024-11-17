// dio_client.dart
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  final Dio _dio;

  DioClient()
      : _dio = Dio(
          BaseOptions(
            baseUrl: 'https://api.shinmag.am/v1',
            connectTimeout: Duration(milliseconds: 5000),
            receiveTimeout: Duration(milliseconds: 3000),
            headers: {
              'accept': 'application/json',
              'Content-Type': 'application/json',
              'X-CSRF-TOKEN': '', // Add token if available or leave empty
            },
          ),
        ) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('auth_token');

        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }

        return handler.next(options);
      },
      onError: (DioError e, handler) {
        return handler.next(e);
      },
    ));
  }

  Dio get dio => _dio;
}
