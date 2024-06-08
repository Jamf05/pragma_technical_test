import 'dart:developer';
import 'package:dio/dio.dart';

class DioInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('REQUEST[${options.method}] => PATH: ${options.path}', name: 'DIO');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    log(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
      name: 'DIO',
    );
    super.onResponse(response, handler);
  }

  @override
  Future<dynamic> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    log('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
        name: 'DIO');
    super.onError(err, handler);
  }
}
