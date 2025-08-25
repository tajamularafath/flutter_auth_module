import 'package:authication_module/core/di/injection_container.dart';
import 'package:authication_module/core/user_preference.dart';
import 'package:authication_module/splash/provider/splash_state.dart';
import 'package:flutter/widgets.dart';

class SplashProvider with ChangeNotifier {
  final _userPrefs = locator<UserPreference>();
  late String initialRoute;
  SplashState state = SplashState.noAction;

  SplashProvider() {
    getInitialRoute();
  }

  /// Get initial Path
  Future<void> getInitialRoute() async {
    initialRoute = await _userPrefs.initialRoute();
    setState(state: SplashState.moveNext);
  }

  /// Set State
  void setState({required SplashState state}) {
    this.state = state;
    notifyListeners();
  }
}
