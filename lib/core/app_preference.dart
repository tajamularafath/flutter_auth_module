import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreference {
  final SharedPreferences preferences;

  AppPreference({required this.preferences});

  /// Default Values
  static const String defaultString = "";
  static const bool defaultBool = false;
  static const int defaultInt = 0;

  /// String Set
  Future<void> setStringPreference(String key, String value) async {
    try {
      preferences.setString(key, value);
    } on Exception catch (exception) {
      return debugPrint(exception.toString());
    }
  }

  /// String Get
  String? getStringPreference(String key) {
    try {
      return preferences.getString(key) ?? defaultString;
    } on Exception catch (exception) {
      debugPrint(exception.toString());
      return null;
    }
  }

  /// Bool Set
  Future<void> setBoolPreference(String key, bool value) async {
    try {
      preferences.setBool(key, value);
    } on Exception catch (exception) {
      return debugPrint(exception.toString());
    }
  }

  /// Bool Get
  bool? getBoolPreference(String key) {
    try {
      return preferences.getBool(key) ?? defaultBool;
    } on Exception catch (exception) {
      debugPrint(exception.toString());
      return null;
    }
  }

  /// Int Set
  Future<void> setIntPreference(String key, int value) async {
    try {
      preferences.setInt(key, value);
    } on Exception catch (exception) {
      debugPrint(exception.toString());
    }
  }

  /// Int Get
  int? getIntPreference(String key) {
    try {
      return preferences.getInt(key) ?? defaultInt;
    } on Exception catch (exception) {
      debugPrint(exception.toString());
      return null;
    }
  }

  /// Remove
  removePreference(String key) async {
    try {
      return preferences.remove(key);
    } on Exception catch (exception) {
      debugPrint(exception.toString());
    }
  }
}
