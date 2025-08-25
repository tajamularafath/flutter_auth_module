import 'package:authication_module/core/app_preference.dart';
import 'package:authication_module/features/auth/domain/use_case/auth_usecase.dart';
import 'package:authication_module/features/auth/presentation/provider/login_provider/login_provider.dart';
import 'package:authication_module/splash/provider/splash_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../user_preference.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  final sharedPreference = await SharedPreferences.getInstance();
  locator.registerSingleton<AppPreference>(
    AppPreference(preferences: sharedPreference),
  );
  locator.registerSingleton<UserPreference>(
    UserPreference(preference: locator<AppPreference>()),
  );

  /// Providers
  locator.registerFactory(() => LoginProvider());
  locator.registerFactory(() => SplashProvider());

  /// Use Case
  locator.registerLazySingleton(() => AuthUseCase());

  /// Domain



  /// Data
}
