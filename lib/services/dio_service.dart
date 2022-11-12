import 'dart:developer';
import 'package:dio/dio.dart';

class DioService {
  final Dio _dio = Dio();

  Future<dynamic> getMethod(String url) async{
    _dio.options.headers['content-Type'] = 'application/json';
    return await _dio.get(
      "",
      options: Options(responseType: ResponseType.json,method: 'GET')
    ).then((response) {
      log(response.toString());
      return response;
    });
  }
}