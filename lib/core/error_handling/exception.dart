import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:pragma_technical_test/core/error_handling/failure.dart';

class ExceptionFailure extends Failure {
  final Exception? error;
  @override
  final String? message;
  ExceptionFailure._({
    this.error,
    this.message,
  });
  factory ExceptionFailure.decode(Exception? error) {
    log(error.toString(), name: 'FAILURE[EXCEPTION]');
    return ExceptionFailure._(
      error: error,
      message: error.toString(),
    );
  }
}

class PlatformFailure extends Failure {
  @override
  final String? message;
  final PlatformException? error;

  PlatformFailure._({
    this.message,
    this.error,
  });

  factory PlatformFailure.decode(PlatformException? error) {
    log((error).toString(), name: 'FAILURE[PLATFORM][ERROR]');
    log((error?.message).toString(), name: 'Failure[PLATFORM][MESSAGE]');
    log((error?.stacktrace).toString(), name: 'Failure[PLATFORM][TRACE]');
    return PlatformFailure._(
      error: error,
      message: error?.message,
    );
  }
}

class DioFailure extends Failure {
  final int? statusCode;
  final Map<String, dynamic>? data;
  final DioException? error;
  @override
  final String? message;
  DioFailure._({
    this.statusCode,
    this.data,
    this.error,
    this.message,
  });
  factory DioFailure.decode(
    DioException? error,
  ) {
    log(error.toString(), name: 'FAILURE[DIO]');
    log((error?.response?.statusCode).toString(),
        name: 'FAILURE[DIO][STATUSCODE]');
    log((error?.message).toString(), name: 'FAILURE[DIO][MESSAGE]');
    log((error?.response?.data).toString(), name: 'FAILURE[DIO][DATA]');
    return DioFailure._(
      error: error,
      statusCode: error?.response?.statusCode,
      message: error?.message,
      data: error?.response?.data,
    );
  }
}
