import 'package:authication_module/constants/exception_message.dart';
import 'package:authication_module/constants/string_constants.dart';
import 'package:authication_module/core/di/injection_container.dart';
import 'package:authication_module/core/exception/app_exception.dart';
import 'package:authication_module/features/auth/domain/use_case/auth_usecase.dart';
import 'package:authication_module/features/auth/presentation/provider/register_provider/register_state.dart';
import 'package:authication_module/utils/parameters/register_params.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

import '../../../data/model/create_user_response.dart';

class RegisterProvider with ChangeNotifier {
  final useCase = locator<AuthUseCase>();
    RegisterState state = RegisterState.initialize;
  CreateUserResponse? createUserResponse;
  String? message;
  DioException? error;

  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final fullNameController = TextEditingController();
  final countryCodeController = TextEditingController();

  bool _isFormValid = false;
  bool get isFormValid => _isFormValid;

  void validateForm() {
    final isValid =
        formKey.currentState?.validate() == true &&
            firstNameController.text.isNotEmpty &&
            lastNameController.text.isNotEmpty &&
            phoneController.text.isNotEmpty &&
            emailController.text.isNotEmpty &&
            passwordController.text.isNotEmpty;

    if (_isFormValid != isValid) {
      _isFormValid = isValid;
      notifyListeners();
    }
  }

  /// API CALL
  Future<dynamic> createAccount() async {
    setState(state: RegisterState.loading);
    final response = await useCase.register(registerParams
        : RegisterParam(
      fullName: "${firstNameController.text} ${lastNameController.text}",
      email: emailController.text,
      phone: phoneController.text,
      countryCode: StringConstants.countryCode,
      password: passwordController.text,
      confirmPassword: confirmPasswordController.text,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      ),
    );
    debugPrint("Response : $response");

    /// Success
    if (response is CreateUserResponse) {
      createUserResponse = response;
      setState(state: RegisterState.success);
    }

    /// Error
    if (response is AppException) {
      error = response.error;
      if (error?.type == DioExceptionType.connectionError) {
        message = ExceptionMessage.noInternet;
      } else {
        switch (response.code) {
          case 422: // 422 In Valid mobile number
            message = StringConstants.inValidMobileNumber;
            break;
          case 409: // 409 Phone already exist
            message = StringConstants.phoneAlreadyExist;
            break;
          case 404: // 404 number not found (Optional)
            message = StringConstants.onNotFound;
            break;
          case 403: // 403 Time out
            message = StringConstants.otpTimeOut;
            break;
          default:
            message = error?.message;
        }
      }
      debugPrint("===> $message");
      setState(state: RegisterState.error);
    }
  }

  /// Set State
  void setState({required RegisterState state}) {
    this.state = state;
    notifyListeners();
  }

  /// Reset form fields and state
  void resetForm() {
    firstNameController.clear();
    lastNameController.clear();
    phoneController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();

    message = null;
    createUserResponse = null;
    _isFormValid = false;
    state = RegisterState.noAction;

    // Optionally reset the form UI if it's mounted
    formKey.currentState?.reset();

    notifyListeners();
  }
}
