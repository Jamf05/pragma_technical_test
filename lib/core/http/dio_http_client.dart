import 'package:dio/dio.dart';
import 'package:pragma_technical_test/core/env.dart';
import 'package:pragma_technical_test/core/http/dio_interceptors.dart';

class DioHttpClient with DioMixin implements Dio {
  DioHttpClient() {
    options = BaseOptions(baseUrl: Env.api);
    httpClientAdapter = HttpClientAdapter();

    interceptors.add(DioInterceptors());
  }
}
