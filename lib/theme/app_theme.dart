import 'package:azkar_app/theme/app_colors/app_color_dark.dart';
import 'package:azkar_app/theme/app_colors/app_light_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColorsLight.primary,
    scaffoldBackgroundColor: AppColorsLight.background,
      colorScheme: ColorScheme.light(
    primary: AppColorsLight.primary,
    background: AppColorsLight.background,
    onPrimary: Colors.white, // لون النص فوق الـ primary
    secondary: AppColorsLight.textSecondary,
    onSecondary: Colors.white, // لون النص فوق الـ secondary
    error: AppColorsLight.textPrimary, // لو حابب تحدده
  ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColorsLight.textPrimary),
      bodyMedium: TextStyle(color: AppColorsLight.textSecondary),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColorsLight.button,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColorsDark.primary,
    scaffoldBackgroundColor: AppColorsDark.background,
     colorScheme: ColorScheme.dark(
    primary: AppColorsDark.primary,
    background: AppColorsDark.background,
    onPrimary: Colors.black,
    secondary: AppColorsDark.textSecondary,
    onSecondary: Colors.black,
    error: AppColorsDark.textPrimary,
  ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColorsDark.textPrimary),
      bodyMedium: TextStyle(color: AppColorsDark.textSecondary),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColorsDark.button,
      ),
    ),
  );
}
