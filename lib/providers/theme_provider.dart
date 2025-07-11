import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  static const THEME_STATUS_KEY = "THEME_STATUS";

  ThemeMode _themeMode;

  // Getter to access the theme mode.
  ThemeMode get themeMode => _themeMode;

  // Getter to check if the current theme is dark.
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  // Now, we pass the initial theme state when the provider is created.
  // This avoids the problem of loading the theme after the UI has been built.
  ThemeProvider({required bool isDark})
      : _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;

  // This method toggles the theme between light and dark.
  void toggleTheme() async {
    _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    _saveThemeToPrefs();
    notifyListeners();
  }

  // Saves the current theme preference to SharedPreferences.
  // This is called whenever the theme is toggled.
  _saveThemeToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_STATUS_KEY, isDarkMode);
  }
}