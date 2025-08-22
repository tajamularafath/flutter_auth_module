import 'package:authication_module/core/app_preference.dart';

class UserPreference{

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

  }

  /// onboard State
  Future<void> setOnBoardState(bool state) =>
}