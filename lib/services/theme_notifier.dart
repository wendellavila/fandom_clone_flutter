import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fandom_clone/services/theme_controller.dart';

class ThemeNotifier extends StateNotifier<ThemeController> {
  ThemeNotifier() : super(ThemeController());

  void switchTheme() {
    if (state.isThemeLight()) {
      state = ThemeController(themeMode: ThemeMode.dark);
    } else {
      state = ThemeController(themeMode: ThemeMode.light);
    }
  }
}

final themeNotifier = StateNotifierProvider<ThemeNotifier, ThemeController>((ref) => ThemeNotifier());
