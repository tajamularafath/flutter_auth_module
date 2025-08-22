import 'package:authication_module/core/di/injection_container.dart';
import 'package:authication_module/features/auth/presentation/screen/login/log_in_screen.dart';
import 'package:authication_module/routes/app_route_path_constants.dart';
import 'package:authication_module/splash/provider/splash_provider.dart';
import 'package:authication_module/splash/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../features/auth/presentation/provider/login_provider/login_provider.dart';

/// This file use to configure route configurations,
/// And set up corresponding screen to the ScreenClass file,

class AppRouteGenerator {
  static MaterialPageRoute? generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case RoutesPathConstants.initialRoute:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => locator<SplashProvider>(),
            child: SplashScreen(),
          ),
        );
      case RoutesPathConstants.loginRoute:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => locator<LoginProvider>(),
            child: LogInScreen(),
          ),
        );
    }
  }
}
