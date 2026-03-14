import 'package:flutter/material.dart';

class AppColors {
  static const Color white = Color(0xFFF9FCFA);
  static const Color blue = Color(0xFF7ACFBE);
  static const Color green = Color(0xFF58C98A);
  static const Color yellow = Color(0xFFE8E9AE);
  static const Color softBlue = Color(0xFFDFF5EF);
  static const Color softGreen = Color(0xFFE9F7ED);
  static const Color softYellow = Color(0xFFF5F4C8);
  static const Color textPrimary = Color(0xFF28453A);
  static const Color textMuted = Color(0xFF6A8578);
  static const Color background = Color(0xFFDCE9DF);
  static const Color borderSoft = Color(0xFFD7E9DD);
  static const Color mintDeep = Color(0xFF3DAA77);
  static const Color mintGlow = Color(0xFFBEEBD1);
}

ThemeData buildAppTheme() {
  const ColorScheme scheme = ColorScheme.light(
    primary: AppColors.green,
    secondary: AppColors.green,
    surface: AppColors.white,
    tertiary: AppColors.blue,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
      centerTitle: true,
      scrolledUnderElevation: 0,
    ),
    cardTheme: CardThemeData(
      color: AppColors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 8,
      shadowColor: const Color(0x14355542),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: AppColors.borderSoft),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.green,
        foregroundColor: AppColors.white,
        textStyle: const TextStyle(fontWeight: FontWeight.w700, letterSpacing: 0.2),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.textPrimary,
        side: const BorderSide(color: AppColors.borderSoft),
        backgroundColor: AppColors.white,
        textStyle: const TextStyle(fontWeight: FontWeight.w700),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(fontWeight: FontWeight.w800, color: AppColors.textPrimary, letterSpacing: 0.2),
      titleLarge: TextStyle(fontWeight: FontWeight.w800, color: AppColors.textPrimary, letterSpacing: 0.2),
      titleMedium: TextStyle(fontWeight: FontWeight.w700, color: AppColors.textPrimary, letterSpacing: 0.1),
      bodyLarge: TextStyle(color: AppColors.textMuted, height: 1.45),
      bodyMedium: TextStyle(color: AppColors.textMuted, height: 1.45),
    ),
  );
}
