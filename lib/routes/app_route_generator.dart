import 'package:authication_module/core/di/injection_container.dart';
import 'package:authication_module/features/auth/presentation/screen/login/log_in_screen.dart';
import 'package:authication_module/features/profile/presentation/screen/help_supports_screen.dart';
import 'package:authication_module/features/profile/presentation/screen/my_order_screen.dart';
import 'package:authication_module/onboarding/bottom_navigation_screen.dart';
import 'package:authication_module/onboarding/provider/bottom_navigation_provider.dart';
import 'package:authication_module/routes/app_route_path_constants.dart';
import 'package:authication_module/splash/provider/splash_provider.dart';
import 'package:authication_module/splash/screen/splash_screen.dart' hide HomeScreen;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../features/auth/presentation/provider/login_provider/login_provider.dart';
import '../features/home/presentation/screen/home_screen.dart';
import '../features/profile/presentation/screen/about_us_screen.dart';
import '../features/profile/presentation/screen/delivered_screen.dart';
import '../features/profile/presentation/screen/notifications_screen.dart';
import '../features/profile/presentation/screen/payment_methods_screen.dart';

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
        case RoutesPathConstants.bottomNavigationRoute:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => locator<BottomNavigationProvider>(),
            child: BottomNavigationScreen(),
          ),
        );
      case RoutesPathConstants.homeRoute:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => locator<LoginProvider>(),
            child: HomeScreen(),
          ),
        );
        case RoutesPathConstants.myOrderRoute:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => locator<LoginProvider>(),
            child: MyOrdersScreen(),
          ),
        );
        case RoutesPathConstants.deliveredRoute:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => locator<LoginProvider>(),
            child: DeliveryAddressScreen(),
          ),
        );
        case RoutesPathConstants.paymentMethodsRoute:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => locator<LoginProvider>(),
            child: PaymentMethodsScreen(),
          ),
        );
        case RoutesPathConstants.helpAndSupportsRoute:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => locator<LoginProvider>(),
            child: HelpSupportScreen(),
          ),
        );
        case RoutesPathConstants.notificationsRoute:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => locator<LoginProvider>(),
            child: NotificationsScreen(),
          ),
        );
        case RoutesPathConstants.aboutUsRoute:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => locator<LoginProvider>(),
            child: AboutUsScreen(),
          ),
        );
    }
    return null;
  }
}
