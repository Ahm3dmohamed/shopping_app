import 'package:dio/dio.dart';

const String baseUrl =
    "https://ecommerce.routemisr.com/"; // Corrected typo and added trailing slash

class ApiManager {
  late Dio dio;
  ApiManager() {
    dio = Dio();
  }

  Future<Response> getData(
      {required String endPoints,
      Map<String, dynamic>? param,
      Map<String, dynamic>? headers}) async {
    return dio.get(
      baseUrl + endPoints, // Corrected variable name
      options: Options(headers: headers),
      queryParameters: param,
    );
  }

  Future<Response> postData(
      {required String endPoints,
      Map<String, dynamic>? param,
      Map<String, dynamic>? body}) async {
    return dio.post(
      // Changed from `get` to `post` for POST requests
      baseUrl + endPoints, // Corrected variable name
      options: Options(headers: body),
      queryParameters: param,
    );
  }
}
