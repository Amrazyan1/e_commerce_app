// dio_client.dart
import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio;

  DioClient()
      : _dio = Dio(
          BaseOptions(
            baseUrl: 'https://api.shinmag.am', // Update with your base URL
            connectTimeout: Duration(milliseconds: 5000),
            receiveTimeout: Duration(milliseconds: 3000),
          ),
        );

  Dio get dio => _dio;
}
