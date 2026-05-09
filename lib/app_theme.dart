import 'package:flutter/material.dart';

class PptTheme {
  static const Color primaryBlue = Color(0xFF4472C4);
  static const Color accentOrange = Color(0xFFED7D31);
  static const Color skyBlue = Color(0xFF5B9BD5);
  static const Color green = Color(0xFF70AD47);
  static const Color warmYellow = Color(0xFFFFC000);
  static const Color surface = Color(0xFFF4F7FB);
  static const Color textDark = Color(0xFF172033);

  static ThemeData buildTheme() {
    final colorScheme =
        ColorScheme.fromSeed(
          seedColor: primaryBlue,
          brightness: Brightness.light,
        ).copyWith(
          primary: primaryBlue,
          secondary: accentOrange,
          tertiary: green,
          surface: Colors.white,
          onSurface: textDark,
        );

    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Arial',
      colorScheme: colorScheme,
      scaffoldBackgroundColor: surface,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFD3D9E6)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFD3D9E6)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: primaryBlue, width: 2),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryBlue,
          side: const BorderSide(color: primaryBlue),
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFFE0E6F0)),
        ),
      ),
    );
  }
}
