import 'package:flutter/material.dart';
// Optionally import SharedPreferences if you want to persist the theme:
//import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeMode _themeMode;

  ThemeNotifier(this._themeMode);

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() async {
    if (_themeMode == ThemeMode.dark) {
      _themeMode = ThemeMode.light;
    } else {
      _themeMode = ThemeMode.dark;
    }
    notifyListeners();

    // Optional: Persist the user's choice.
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setBool("isDarkMode", _themeMode == ThemeMode.dark);
  }

  // Optional: A method to load the theme from persistence.
  // Future<void> loadThemeMode() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool isDark = prefs.getBool("isDarkMode") ?? false;
  //   _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
  //   notifyListeners();
  // }
}
