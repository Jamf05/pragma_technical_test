import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:pragma_technical_test/core/env.dart';

class DioInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({
      'x-api-key': Env.apiKey,
    });
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
