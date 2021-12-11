import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response>? getRequest({
    required String path,
    Map<String, dynamic>? queryParameters,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'content_type': 'application/json',
      'Authorization': token,
    };

    return await dio.get(path, queryParameters: queryParameters);
  }

  static Future<Response> postRequest({
    required String path,
    Map<String, dynamic>? queryParameters,
    required Map<String, dynamic>? data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'content_type': 'application/json',
      'Authorization': token,
    };

    return await dio.post(
      path,
      queryParameters: queryParameters,
      data: data,
    );
  }
}
