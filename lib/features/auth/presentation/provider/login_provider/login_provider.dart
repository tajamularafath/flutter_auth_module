import 'package:authication_module/constants/exception_message.dart';
import 'package:authication_module/constants/key_constants.dart';
import 'package:authication_module/constants/string_constants.dart';
import 'package:authication_module/core/di/injection_container.dart';
import 'package:authication_module/core/exception/app_exception.dart';
import 'package:authication_module/core/user_preference.dart';
import 'package:authication_module/features/auth/data/model/login_response_model.dart';
import 'package:authication_module/features/auth/domain/use_case/auth_usecase.dart';
import 'package:authication_module/features/auth/presentation/provider/login_provider/login_state.dart';
import 'package:authication_module/utils/parameters/login_params.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

class LoginProvider with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final useCase = locator<AuthUseCase>();
  final _prefs = locator<UserPreference>();
  LoginState state = LoginState.initialize;
  LoginResponseModel? loginResponseModel;
  String? message;
  DioException? error;

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isFormValid = false;

  bool get isFormValid => _isFormValid;

  void _validateForm() {
    final isValid = phoneController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        formKey.currentState?.validate() == true;

    if (_isFormValid != isValid) {
      _isFormValid = isValid;
      notifyListeners();
    }
  }

  /// API CALL
  void login() async {
    setState(state: LoginState.loading);
    final response = await useCase.login(loginParams: LoginParam(
        phone: phoneController.text.trim(),
        password: passwordController.text.trim()));
    debugPrint("Response : $response");

    /// Success
    if(response is LoginResponseModel){
      loginResponseModel = response;
      storeLocalData();
      setState(state: LoginState.success);
    }
    /// Error
    if(response is AppException){
      error = response.error;
      if(error?.type == DioExceptionType.connectionError) {
        message = ExceptionMessage.noInternet;
      } else {
        switch (response.code){
          case 401:
            message = StringConstants.inCorrectPassword;
            break;
          case 404:
            message = StringConstants.onNotFound;
            break;
          default:
            message = error?.message;
        }
      }
      debugPrint("===> $message");
      setState(state: LoginState.error);
    }
  }

  /// Set State
  void setState({required LoginState state}) {
    this.state = state;
    notifyListeners();
  }

  void storeLocalData() async {
    if(loginResponseModel == null) return;
    await _prefs.setLoginState(true);
    await _prefs.setLoginToken(loginResponseModel!.token ?? '');
    await _prefs.setLoginMobileNumber(loginResponseModel!.userName ?? '');
  }
}
