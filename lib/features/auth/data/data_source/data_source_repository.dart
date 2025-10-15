import 'package:authication_module/utils/parameters/login_params.dart';

import '../../../../utils/parameters/register_params.dart';

abstract class AuthDataSourceRepository{

  /// Login
  Future<dynamic> login({required LoginParam loginParams});

  /// Register
  Future<dynamic> register({required RegisterParam registerParams});
}