import 'package:authication_module/core/app_preference.dart';
import 'package:authication_module/routes/app_route_path_constants.dart';
import 'package:flutter/cupertino.dart';

class UserPreference {
  final AppPreference preference;

  UserPreference({required this.preference});

  static const String onBoardState = 'onboardState';
  static const String loginState = 'loginState';
  static const String loginToken = 'loginToken';
  static const String loginMobileNumber = 'loginMobileNumber';

  Future<String> initialRoute() async {
    // Debugging login and onboard states
    debugPrint('Onboard state: ${getOnboardState()}');
    debugPrint('Login state: ${getLoginState()}');
    debugPrint('Login Token: ${getLoginToken()}');

    /// App Sign In State == True
    if (getLoginState() == true) {
      return RoutesPathConstants.bottomNavigationRoute;
    } else if (getOnboardState() == true) {
      return RoutesPathConstants.loginRoute;
    }
    /// App first opening state
    else {
      return RoutesPathConstants.loginRoute;
    }
  }

  /// onboard State
  Future<void> setOnBoardState(bool state) =>
      preference.setBoolPreference(onBoardState, state);

  bool getOnboardState() => preference.getBoolPreference(onBoardState) ?? false;

  /// Login State
  Future<void> setLoginState(bool setState) =>
      preference.setBoolPreference(loginState, setState);

  bool getLoginState() => preference.getBoolPreference(loginState) ?? false;

  /// Set Login Token
  Future<void> setLoginToken(String token) {
    return preference.setStringPreference(loginToken, token);
  }

  String? getLoginToken() {
    return preference.getStringPreference(loginToken) ?? '';
  }

  /// Set Login Mobile Number
  Future<void> setLoginMobileNumber(String number) {
    return preference.setStringPreference(loginMobileNumber, number);
  }

  String? getLoginMobilrNumber() {
    return preference.getStringPreference(loginMobileNumber);
  }
}
