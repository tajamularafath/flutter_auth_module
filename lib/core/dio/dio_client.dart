
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
class DioClient {
  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;
  late Dio dio;
  final Logger _logger = Logger();

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 20),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'multipart/form-data',
        },
      ),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          /*final requiresToken = options.extra["requiresToken"] ?? true;
          if (requiresToken) {
            final token = await _getToken();
            options.headers["Authorization"] = "Bearer $token";
          }*/
          String bodyLog = '';
          if (options.data is FormData) {
            final formData = options.data as FormData;
            bodyLog = formData.fields
                .map((e) => '${e.key}: ${e.value}')
                .join(', ');
            if (formData.files.isNotEmpty) {
              final files = formData.files
                  .map((f) => '${f.key}: ${f.value.filename}')
                  .join(', ');
              bodyLog += '\n📎 FILES: $files';
            }
          } else if (options.data is Map || options.data is List) {
            bodyLog = const JsonEncoder.withIndent('  ').convert(options.data);
          } else {
            bodyLog = options.data?.toString() ?? '';
          }
          _logger.i('''
            ➡️ Request [${options.method}]
            => PATH: ${options.baseUrl}${options.path}
            => QUERY: ${options.queryParameters}
            => BODY: $bodyLog
            ''');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          _logger.i(
            "✅ Response [${response.statusCode}] => DATA: ${response.data}",
          );
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          _logger.e("❌ Error => ${e.message}");
          return handler.next(e);
        },
      ),
    );
  }
}

