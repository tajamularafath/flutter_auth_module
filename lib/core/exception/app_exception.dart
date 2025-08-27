import 'package:dio/dio.dart';

class AppException implements Exception {
  final int? code;
  final DioException? error;
  final String? url;

  AppException(
      {required this.code,
        required this.error,
        required this.url});
}
