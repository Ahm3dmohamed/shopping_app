// lib/core/api/api_manager.dart

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

const String baseUrl = "https://ecommerce.routemisr.com/";

// @lazySingleton
class ApiManager {
  late Dio dio;

  ApiManager() {
    dio = Dio();
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }

  Future<Response> getData({
    required String endPoints,
    Map<String, dynamic>? param,
    Map<String, dynamic>? headers,
  }) async {
    return dio.get(
      endPoints,
      options: Options(headers: headers),
      queryParameters: param,
    );
  }

  Future<Response> postData({
    required String endPoints,
    Map<String, dynamic>? param,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
  }) async {
    return dio.post(
      baseUrl + endPoints,
      data: body,
      queryParameters: param,
      options: Options(headers: headers),
    );
  }
}
