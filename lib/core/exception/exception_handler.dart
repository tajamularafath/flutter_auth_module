

import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../constants/url_constants.dart';
import 'app_exception.dart';

/*class ExceptionHandlers {
  static getExceptionString({required DioException error, required int code, required String url}) {
    if (error is SocketException) {
      return AppException(code: code, message: ExceptionMessage.noInternet, url: url);
    } else if (error is HttpException) {
      return AppException(code: code, message: ExceptionMessage.httpError, url: url);
    } else if (error is FormatException) {
      return AppException(code: code, message: ExceptionMessage.dataError, url: url);
    } else if (error is TimeoutException) {
      return AppException(code: code, message: ExceptionMessage.timeError, url: url);
    } else if (code == 400) {
      return AppException(code: code, message: ExceptionMessage.badError, url: url);
    } else if (code == 401) {
      return AppException(code: code, message: ExceptionMessage.unAutError, url: url);
    } else if (code == 403) {
      return AppException(code: code, message: ExceptionMessage.unAutError, url: url);
    } else if (code == 404) {
      return AppException(code: code, message: ExceptionMessage.notFoundError, url: url);
    } else if (code == 405) {
      return AppException(code: code, message: ExceptionMessage.methodFoundError, url: url);
    } else if (code == 408) {
      return AppException(code: code, message: ExceptionMessage.timeError, url: url);
    } else if (code == 422) {
      if (url.contains(UrlConstants.verifyOtp)) {
        return AppException(code: code, message: ExceptionMessage.invalidOtp, url: url);
      } else {
        return AppException(code: code, message: ExceptionMessage.unknownError, url: url);
      }
    } else if (code == 429) {
      return AppException(code: code, message: ExceptionMessage.toManyRequests, url: url);
    } else if (code == 500) {
      return AppException(code: code, message: ExceptionMessage.internalServerError, url: url);
    } else if (code == 502) {
      return AppException(code: code, message: ExceptionMessage.badGatewayError, url: url);
    } else if (code == 208) {
      return AppException(code: code, message: ExceptionMessage.alreadyResponded, url: url);
    } else {
      return AppException(code: code, message: ExceptionMessage.unknownError, url: url);
    }
  }
}*/
