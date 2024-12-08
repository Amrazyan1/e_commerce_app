// dio_client.dart
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  final Dio _dio;

  DioClient()
      : _dio = Dio(
          BaseOptions(
            baseUrl: 'http://imexpro.am/v1',
            connectTimeout: Duration(milliseconds: 60 * 1000),
            receiveTimeout: Duration(milliseconds: 60 * 1000),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Accept-Language': 'en',
              'Accept': 'application/json',
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
        options.contentType = Headers.jsonContentType;
        log('---------------Request -> ${Uri.decodeFull(options.uri.toString())} ---------------------');
        log('${options.data}');
        // log('------------------------------------');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // Manually decode response if it's a String
        response.data = json.encode(response.data);
        log('---------------Response---------------------');
        log(response.data);
        // if (response.data is String) {
        //   try {
        //     response.data = json.decode(response.data);
        //   } catch (e) {
        //     // Log or handle the case where decoding fails
        //     print('Failed to decode response: $e');
        //   }
        // }
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        return handler.next(e);
      },
    ));
  }

  Dio get dio => _dio;
}
