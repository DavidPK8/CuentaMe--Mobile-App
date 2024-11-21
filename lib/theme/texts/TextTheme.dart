// ignore_for_file: file_names

import 'package:flutter/material.dart';

class AppTextTheme {
  static TextTheme getTextTheme() {
    return const TextTheme(
      // Textos grandes para encabezados destacados
      displayLarge: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w800, // ExtraBold
        fontSize: 32,
        letterSpacing: 1.2,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700, // Bold
        fontSize: 28,
        letterSpacing: 1.1,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600, // SemiBold
        fontSize: 24,
        letterSpacing: 1.1,
      ),
      // Encabezados estándar
      headlineLarge: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700, // Bold
        fontSize: 22,
        letterSpacing: 1.0,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600, // SemiBold
        fontSize: 20,
        letterSpacing: 1.0,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500, // Medium
        fontSize: 18,
        letterSpacing: 0.9,
      ),
      // Títulos y etiquetas
      titleLarge: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600, // SemiBold
        fontSize: 16,
        letterSpacing: 0.85,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500, // Medium
        fontSize: 14,
        letterSpacing: 0.8,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400, // Regular
        fontSize: 12,
        letterSpacing: 0.75,
      ),
      // Textos del cuerpo (HostGrotesk)
      bodyLarge: TextStyle(
        fontFamily: 'HostGrotesk',
        fontWeight: FontWeight.w400, // Regular
        fontSize: 16,
        letterSpacing: 0.8,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'HostGrotesk',
        fontWeight: FontWeight.w300, // Light
        fontSize: 14,
        letterSpacing: 0.75,
      ),
      bodySmall: TextStyle(
        fontFamily: 'HostGrotesk',
        fontWeight: FontWeight.w300, // Light
        fontSize: 12,
        letterSpacing: 0.7,
      ),
      // Etiquetas pequeñas y botones
      labelLarge: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500, // Medium
        fontSize: 14,
        letterSpacing: 1.0,
      ),
      labelMedium: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400, // Regular
        fontSize: 12,
        letterSpacing: 0.8,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w300, // Light
        fontSize: 10,
        letterSpacing: 0.7,
      ),
    );
  }

  static ThemeData getAppTheme() {
    return ThemeData(
      textTheme: getTextTheme(),
      primaryTextTheme: getTextTheme(),
      // Otros estilos del tema pueden ir aquí, como colores.
    );
  }
}
