import '../../../../utils/parameters/login_params.dart';

abstract class AuthRepository {

  /// Login
  Future<dynamic> login({required LoginParam loginParams});
}