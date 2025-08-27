import 'package:authication_module/routes/app_route_generator.dart';
import 'package:authication_module/routes/app_route_path_constants.dart';
import 'package:authication_module/theme/theme.dart';
import 'package:flutter/material.dart';

import 'core/di/injection_container.dart';
import 'features/auth/presentation/screen/login/log_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: RoutesPathConstants.initialRoute,
      onGenerateRoute: AppRouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      theme: theme,
    );
  }
}

