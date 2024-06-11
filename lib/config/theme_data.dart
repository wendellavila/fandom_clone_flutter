import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData themeData({required BuildContext context, required ThemeMode themeMode}) {
  final lightTheme = ThemeData(
    iconTheme: const IconThemeData(color: Color(0XFF3A3A3A)),
    textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Color(0XFF3A3A3A)),
        bodyMedium: TextStyle(color: Color(0XFF3A3A3A)),
        bodySmall: TextStyle(color: Color(0XFF3A3A3A))),
    appBarTheme: const AppBarTheme(color: Color(0XFF001225)),
    useMaterial3: false,
    fontFamily: GoogleFonts.rubik().fontFamily,
    colorScheme: Theme.of(context).colorScheme.copyWith(
        primary: const Color(0XFF001225),
        primaryContainer: const Color(0XFFf2f2f2),
        onPrimary: Colors.white,
        onPrimaryContainer: const Color(0XFF3A3A3A),
        secondary: const Color(0XFFE77484),
        onSecondary: const Color(0XFF3A3A3A),
        tertiary: const Color(0XFF037ABF)),
    scaffoldBackgroundColor: Colors.white,
    listTileTheme: const ListTileThemeData(
      iconColor: Color(0XFF3A3A3A),
      textColor: Color(0XFF3A3A3A),
    ),
  );

  final darkTheme = ThemeData(
    iconTheme: const IconThemeData(color: Color(0XFFE6E6E6)),
    textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Color(0XFFE6E6E6)),
        bodyMedium: TextStyle(color: Color(0XFFE6E6E6)),
        bodySmall: TextStyle(color: Color(0XFFE6E6E6))),
    appBarTheme: const AppBarTheme(color: Color(0XFF037ABF)),
    useMaterial3: false,
    fontFamily: GoogleFonts.rubik().fontFamily,
    colorScheme: Theme.of(context).colorScheme.copyWith(
        primary: const Color(0XFF037ABF),
        primaryContainer: const Color(0XFF263646),
        onPrimary: Colors.white,
        onPrimaryContainer: Colors.white,
        secondary: const Color(0XFFB84D68),
        onSecondary: const Color(0XFFE6E6E6),
        tertiary: const Color(0XFF40A4FF)),
    scaffoldBackgroundColor: const Color(0XFF001225),
    listTileTheme: const ListTileThemeData(
      iconColor: Colors.white,
      textColor: Colors.white,
    ),
  );

  return themeMode == ThemeMode.light ? lightTheme : darkTheme;
}
