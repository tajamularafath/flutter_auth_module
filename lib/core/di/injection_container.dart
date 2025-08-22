

import 'package:authication_module/core/app_preference.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../user_preference.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async{
  final sharedPreference = await SharedPreferences.getInstance();
  locator.registerSingleton<AppPreference>(AppPreference(preferences: sharedPreference));
  locator.registerSingleton<UserPreference>(UserPreference(preference: locator<AppPreference>()));


}