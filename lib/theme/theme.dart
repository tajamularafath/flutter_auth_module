import 'package:authication_module/constants/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    primary: AppColors.primary,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return AppColors.primaryDisabled;
        }
        return AppColors.primary;
      }),
      overlayColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
          ) {
        if (states.contains(WidgetState.pressed)) {
          return Colors.white.withValues(alpha: 0.2); // tint on press
        }
        if (states.contains(WidgetState.hovered)) {
          return Colors.white.withValues(alpha: 0.1); // tint on hover
        }
        return null; // default
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return AppColors.onPrimary;
        }
        return AppColors.onPrimary;
      }),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      minimumSize: WidgetStateProperty.all(Size.fromHeight(48)),
      textStyle: WidgetStateProperty.all(
        const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Colors.white,
  ),
);
