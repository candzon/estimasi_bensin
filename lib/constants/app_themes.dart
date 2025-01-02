import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppThemes {
  static ThemeData createThemeData(Map<String, Color> colors) {
    return ThemeData(
      useMaterial3: true,
      primaryColor: colors['primary'],
      primaryColorLight: colors['primaryLight'],
      primaryColorDark: colors['primaryDark'],
      hintColor: colors['accent'],
      scaffoldBackgroundColor: colors['background'],
      textTheme: TextTheme(
        displayLarge: TextStyle(
          // * 96px - Sangat besar, untuk splash screen atau intro
          color: colors['textPrimary'],
          fontSize: 96,
        ),
        displayMedium: TextStyle(
          // * 60px - Ukuran untuk judul utama yang dramatis
          color: colors['textPrimary'],
          fontSize: 60,
        ),
        displaySmall: TextStyle(
          // * 48px - Ukuran untuk judul yang menonjol
          color: colors['textPrimary'],
          fontSize: 48,
        ),
        headlineMedium: TextStyle(
          // * 34px - Ukuran untuk heading level 1
          color: colors['textPrimary'],
          fontSize: 34,
        ),
        headlineSmall: TextStyle(
          // * 24px - Ukuran untuk heading level 2
          color: colors['textPrimary'],
          fontSize: 24,
        ),
        titleLarge: TextStyle(
          // * 20px - Ukuran untuk judul card atau dialog
          color: colors['textPrimary'],
          fontSize: 20,
        ),
        titleMedium: TextStyle(
          // * 16px - Ukuran untuk subtitle atau menu items
          color: colors['textSecondary'],
          fontSize: 16,
        ),
        titleSmall: TextStyle(
          // * 14px - Ukuran untuk caption atau helper text
          color: colors['textSecondary'],
          fontSize: 14,
        ),
        bodyLarge: TextStyle(
          // * 16px - Ukuran untuk body text utama
          color: colors['textPrimary'],
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          // * 14px - Ukuran untuk body text sekunder
          color: colors['textSecondary'],
          fontSize: 14,
        ),
      ),
      appBarTheme: AppBarTheme(
        color: colors['primary'],
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: TextStyle(
          color: colors['surface'],
          fontSize: 20,
        ),
        elevation: 0,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: colors['primary']!,
        primary: colors['primary']!,
        secondary: colors['accent']!,
        surface: colors['surface']!,
        error: colors['error']!,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: colors['textPrimary']!,
        onError: Colors.white,
        surfaceTint: colors['primaryLight']!,
        surfaceContainerHighest: colors['background']!,
        onSurfaceVariant: colors['textSecondary']!,
      ),
    );
  }
}
