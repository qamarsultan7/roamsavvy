import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF0F4C81),
    scaffoldBackgroundColor: const Color(0xFFF7F9FB),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFFFFFFF),
      foregroundColor: Color(0xFF1E1E1E),
      elevation: 0,
    ),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF0F4C81),
      secondary: Color(0xFFF29F05),
      surface: Color(0xFFFFFFFF),
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      error: Color(0xFFD62828),
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: 16, color: Color(0xFF1E1E1E)),
      bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
    ),
    useMaterial3: true,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF8AB4F8),
    scaffoldBackgroundColor: const Color(0xFF0D1117),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF161B22),
      foregroundColor: Color(0xFFE5E7EB),
      elevation: 0,
    ),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF8AB4F8),
      secondary: Color(0xFFFBBF24),
      surface: Color(0xFF161B22),
      onPrimary: Color(0xFF0D1117),
      onSecondary: Colors.black,
      error: Color(0xFFEF4444),
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFFE5E7EB)),
      bodyLarge: TextStyle(fontSize: 16, color: Color(0xFFE5E7EB)),
      bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF9CA3AF)),
    ),
    useMaterial3: true,
  );
}
