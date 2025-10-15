

import 'package:authication_module/features/auth/data/data_source/data_source_repository.dart';
import 'package:authication_module/utils/parameters/register_params.dart';

import '../../../../utils/parameters/login_params.dart';
import '../../domain/repository/auth_repository.dart';

class AuthRepositoryImplementation extends AuthRepository {

  final AuthDataSourceRepository authDataSourceRepository;

  AuthRepositoryImplementation({required this.authDataSourceRepository});

  /// Login
  @override
  Future<dynamic> login({required LoginParam loginParams}) async {
    final response = await authDataSourceRepository.login(loginParams: loginParams);
    return response;
  }

  @override
  Future<dynamic> register({required RegisterParam registerParams}) async{
    final response = await authDataSourceRepository.register(registerParams: registerParams);
    return response;
  }


}
