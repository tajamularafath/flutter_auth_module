import '../../../../utils/parameters/login_params.dart';
import '../../../../utils/parameters/register_params.dart';

abstract class AuthRepository {

  /// Login
  Future<dynamic> login({required LoginParam loginParams});

  /// Register
  Future<dynamic> register({required RegisterParam registerParams});
}