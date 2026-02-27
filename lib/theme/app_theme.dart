import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const LinearGradient lightGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFC2DEE7),
      Color(0xFFC2DEE7),
      Color(0xFFC2DEE7),
      Color(0xFFC2DEE7),
      Color.fromARGB(255, 246, 197, 151),
    ],
  );
  static const LinearGradient darkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF222020), Color(0xFF000000)],
  );
  static final lightTheme = ThemeData().copyWith(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.transparent,
    bottomAppBarTheme: const BottomAppBarThemeData().copyWith(
      color: Colors.transparent,
    ),
    cardTheme: const CardThemeData().copyWith(color: Colors.transparent),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.inriaSerif(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
      bodyLarge: GoogleFonts.inriaSerif(
        color: Colors.black,
        fontSize: 35,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: GoogleFonts.inriaSerif(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
      bodySmall: GoogleFonts.inriaSerif(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
  static final darkTheme = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.transparent,
    cardTheme: const CardThemeData().copyWith(),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.inriaSerif(
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
      bodyLarge: GoogleFonts.inriaSerif(
        fontSize: 35,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: GoogleFonts.inriaSerif(
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
      bodySmall: GoogleFonts.inriaSerif(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
  static const LinearGradient lightCardGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFD2E2E2), Color(0xFFDEC4A2)],
  );
  static const LinearGradient darkCardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1E1E1E), Color(0xFF121212)],
  );
  static const LinearGradient lightBNBGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFFD2E2E2), Color(0xFFDEC4A2)],
  );
  static const LinearGradient darkBNBGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF1E1E1E), Color(0xFF121212)],
  );
}
