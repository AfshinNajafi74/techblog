import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio_service;

class DioService {
  final Dio _dio = Dio();

  Future<dynamic> getMethod(String url) async{
    _dio.options.headers['content-Type'] = 'application/json';
    return await _dio.get(
        url,
      options: Options(responseType: ResponseType.json,method: 'GET')
    ).then((response) {
      log(response.toString());
      return response;
    }).catchError((err){
      if(err is DioError){
        return err.response!;
      }
    });
  }

  Future<dynamic> postMethod(Map<String,dynamic> map , String url) async {
    _dio.options.headers['content-Type'] = 'application/json';
    // TODO => read token from storage
    return await _dio.post(
        url,
        data: dio_service.FormData.fromMap(map),
        options: Options(responseType: ResponseType.json,method: 'POST')).then((response) {
        log(response.headers.toString());
        log(response.data.toString());
        log(response.statusCode.toString());
        return response;
    }).catchError((err){
      if(err is DioError){
        return err.response!;
      }
    });
  }
}