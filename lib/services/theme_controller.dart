import 'package:flutter/material.dart';

class ThemeController {
  ThemeController({this.themeMode = ThemeMode.light});
  ThemeMode themeMode;

  void switchTheme() {
    if (themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }
  }

  ThemeMode get theme => themeMode;

  bool isThemeLight() {
    return themeMode == ThemeMode.light;
  }

  bool isThemeDark() {
    return !isThemeLight();
  }
}
