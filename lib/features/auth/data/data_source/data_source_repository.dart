import 'package:authication_module/utils/parameters/login_params.dart';

abstract class AuthDataSourceRepository{

  /// Login
  Future<dynamic> login({required LoginParam loginParams});
}