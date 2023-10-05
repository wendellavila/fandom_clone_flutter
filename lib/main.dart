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
              primary: const Color(0XFFE77484),
              secondary: const Color(0XFF037ABF),
              tertiary: const Color(0XFF001225)),
          scaffoldBackgroundColor: Colors.white),
      darkTheme: ThemeData(
          appBarTheme: const AppBarTheme(color: Color(0XFF037ABF)),
          useMaterial3: false,
          fontFamily: GoogleFonts.rubik().fontFamily,
          colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: const Color(0XFFB84D68),
              secondary: const Color(0XFF40A4FF),
              tertiary: const Color(0XFF001225)),
          scaffoldBackgroundColor: const Color(0XFF001225)),
      themeMode: ThemeMode.system,
      home: const CategoryPage(),
    );
  }
}
