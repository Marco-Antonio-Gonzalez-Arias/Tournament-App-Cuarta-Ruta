import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeModeOption { system, light, dark }

class ThemeProvider extends ChangeNotifier {
  ThemeModeOption _themeMode = ThemeModeOption.system;
  ThemeModeOption get themeMode => _themeMode;

  ThemeProvider() {
    _loadTheme();
  }

  bool isDarkMode(BuildContext context) {
    if (_themeMode == ThemeModeOption.system) {
      return MediaQuery.platformBrightnessOf(context) == Brightness.dark;
    }
    return _themeMode == ThemeModeOption.dark;
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt('themeMode') ?? 0;
    _themeMode = ThemeModeOption.values[index];
    notifyListeners();
  }

  void setThemeMode(ThemeModeOption option) async {
    _themeMode = option;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', option.index);
  }
}
