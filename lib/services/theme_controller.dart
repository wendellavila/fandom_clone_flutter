import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  void switchTheme() {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }
    notifyListeners();
  }

  ThemeMode get theme => _themeMode;

  bool isThemeLight() {
    return _themeMode == ThemeMode.light;
  }

  bool isThemeDark() {
    return !isThemeLight();
  }
}
