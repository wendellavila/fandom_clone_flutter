import 'package:flutter/material.dart';
import 'package:fandom_clone/ui/screens/category_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FANDOM Clone',
      theme: ThemeData(
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
          scaffoldBackgroundColor: Colors.white),
      darkTheme: ThemeData(
          appBarTheme: const AppBarTheme(color: Color(0XFF037ABF)),
          useMaterial3: false,
          fontFamily: GoogleFonts.rubik().fontFamily,
          colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: const Color(0XFF037ABF),
              primaryContainer: const Color(0XFF263646),
              onPrimary: Colors.white,
              onPrimaryContainer: Colors.white,
              secondary: const Color(0XFFB84D68),
              tertiary: const Color(0XFF40A4FF)),
          scaffoldBackgroundColor: const Color(0XFF001225)),
      themeMode: ThemeMode.system,
      home: const CategoryPage(),
    );
  }
}
