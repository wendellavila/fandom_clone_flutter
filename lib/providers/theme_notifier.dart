import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeState {
  ThemeState({ThemeMode themeMode = ThemeMode.light}) : _themeMode = themeMode;
  ThemeMode _themeMode;

  ThemeMode get theme => _themeMode;
  bool get isThemeLight => _themeMode == ThemeMode.light;
  bool get isThemeDark => !isThemeLight;
  ThemeMode get inverseTheme => isThemeLight ? ThemeMode.dark : ThemeMode.light;
  ThemeState get inverseState => ThemeState(themeMode: inverseTheme);

  void switchTheme() {
    _themeMode = inverseTheme;
  }
}

class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier() : super(ThemeState());

  void switchTheme() {
    state = state.inverseState;
  }
}

final themeNotifier = StateNotifierProvider<ThemeNotifier, ThemeState>((ref) => ThemeNotifier());
