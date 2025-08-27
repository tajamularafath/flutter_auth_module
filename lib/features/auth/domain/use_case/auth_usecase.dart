import 'package:authication_module/features/auth/domain/repository/auth_repository.dart';
import 'package:authication_module/utils/parameters/login_params.dart';

class AuthUseCase {

  final AuthRepository authRepository;

  AuthUseCase({required this.authRepository});

  /// Login
  Future<dynamic> login({ required LoginParam loginParams}) async {
    final response = await authRepository.login(loginParams: loginParams);
    return response;
  }
}