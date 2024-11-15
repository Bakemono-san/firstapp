// lib/themes/custom_theme.dart
import 'package:flutter/material.dart';

class Themeconfig {
  // Define the colors
  static const Color primaryColor = Color.fromARGB(255, 235, 6, 158);
  static const Color secondaryColor = Color(0xFF03DAC6);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color errorColor = Color(0xFFB00020);
  static const Color successColor = Color(0xFF008000);
  static const Color warningColor = Color(0xFFFFA500);
  static const Color disabledColor = Color(0xFFBDBDBD);
  static const Color mainColor = Color.fromARGB(255, 235, 6, 158);

  // Define the Text themes
  static TextTheme textTheme = TextTheme(
    headlineLarge: TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: primaryColor,
    ),
    headlineMedium: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.normal,
      color: Colors.black87,
    ),
    headlineSmall: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      color: Colors.black54,
    ),
  );

  // Define button theme
  static ButtonThemeData buttonTheme = ButtonThemeData(
    buttonColor: primaryColor, // Background color for buttons
    textTheme: ButtonTextTheme.primary, // Text color for buttons
  );

  // Define AppBar theme
  static AppBarTheme appBarTheme = AppBarTheme(
    backgroundColor: primaryColor,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  );

  // Define a custom ThemeData
  static ThemeData themeData = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    textTheme: textTheme,
    buttonTheme: buttonTheme,
    appBarTheme: appBarTheme,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
