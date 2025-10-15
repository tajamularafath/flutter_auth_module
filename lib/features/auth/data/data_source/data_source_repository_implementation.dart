import 'dart:convert';

import 'package:authication_module/features/auth/data/data_source/data_source_repository.dart';
import 'package:authication_module/utils/parameters/register_params.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../../constants/key_constants.dart';
import '../../../../constants/url_constants.dart';
import '../../../../core/dio/dio_client.dart';
import '../../../../core/exception/app_exception.dart';
import '../../../../utils/parameters/login_params.dart';
import '../model/create_user_response.dart';
import '../model/login_response_model.dart';

class AuthDataSourceRepositoryImplementation extends AuthDataSourceRepository {

  /// Login
  @override
  Future<dynamic> login({required LoginParam loginParams}) async {
    final dio = DioClient().dio;

    /// API request url
    var url = UrlConstants.baseUrl + UrlConstants.login;

    const username = 'admin';
    const password = 'admin';
    String basicAuth =
        ' Basic ${base64Encode(utf8.encode('$username:$password'))}';

    /// Set Headers
    dio.options.headers['Authorization'] = basicAuth;
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Content-Type'] = 'multipart/form-data';
    dio.options.headers['x-org-id'] = '1';
    dio.options.headers['version'] = '1.1';

    /// Form Data
    FormData formData = FormData.fromMap({
      'phone': loginParams.phone,
      'password': loginParams.password,
    });

    try {
      final response = await dio
          .post(url, data: formData)
          .timeout(const Duration(minutes: requestTimeOut));
      return LoginResponseModel.fromJson(
        json.decode(jsonEncode(response.data)),
      );
    } on DioException catch (error) {
      if (error.response != null) {
        debugPrint("API Url => $url");
        debugPrint("DioException => ${error.response?.toString()}");
      }
      return AppException(
        error: error,
        code: error.response?.statusCode,
        url: url,
      );
    }
  }

  /// Register
  @override
  Future<dynamic> register({required RegisterParam registerParams}) async {
    final dio = DioClient().dio;

    /// API Request URL
    var url = UrlConstants.baseUrl + UrlConstants.createAccount;

    const username = 'admin';
    const password = 'admin';
    String basicAuth =
        ' Basic ${base64Encode(utf8.encode('$username:$password'))}';

    /// Set Headers
    dio.options.headers['Authorization'] = basicAuth;
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Content-Type'] = 'multipart/form-data';
    dio.options.headers['x-org-id'] = '1';
    //dio.options.headers['x-branch-id'] = '2';
    dio.options.headers['version'] = '1.1';

    /// Form data
    FormData formData = FormData.fromMap({
      'first_name': registerParams.firstName,
      'last_name': registerParams.lastName,
      'email': registerParams.email,
      'phone': registerParams.phone,
      'country': registerParams.countryCode,
      'password': registerParams.password,
      'confirm-password': registerParams.confirmPassword,
      'full_name': registerParams.fullName,
    });

    try {
      final response = await dio
          .post(url, data: formData)
          .timeout(const Duration(minutes: requestTimeOut));

      return CreateUserResponse.fromJson(
        json.decode(jsonEncode(response.data)),
      );
    } on DioException catch (error) {
      if(error.response != null){
        debugPrint("API Url => $url");
        debugPrint("DioException => ${error.response?.toString()}");
      } return AppException(
          error: error,
          code: error.response?.statusCode,
          url: url);
    }
  }
}