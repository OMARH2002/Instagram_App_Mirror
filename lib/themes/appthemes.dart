import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white, // White in light mode
    ),
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white, // Black in dark mode

    ),
  );
}