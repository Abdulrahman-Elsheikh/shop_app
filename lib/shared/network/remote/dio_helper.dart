import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/v2/',
        receiveDataWhenStatusError: true,
        connectTimeout: 5000,
        receiveTimeout: 5000,
      ),
    );
    // dio.options.baseUrl = 'https://newsapi.org/v2/';
    // dio.options.connectTimeout = 5000;
    // dio.options.receiveTimeout = 5000;
    // dio.options.headers = {
    //   'Content-Type': 'application/json',
    //   'Accept': 'application/json',
    // };
  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
  }) async {
    return await dio.get(url, queryParameters: query);
  }
}
