import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeModeOption { system, light, dark }

class ThemeProvider extends ChangeNotifier {
  final SharedPreferences _prefs;
  static const String _themeKey = 'themeMode';

  ThemeModeOption _themeMode = ThemeModeOption.system;
  ThemeModeOption get themeMode => _themeMode;

  ThemeProvider(this._prefs) {
    _loadTheme();
  }

  bool isDarkMode(BuildContext context) {
    if (_themeMode == ThemeModeOption.system) {
      return MediaQuery.platformBrightnessOf(context) == Brightness.dark;
    }
    return _themeMode == ThemeModeOption.dark;
  }

  void _loadTheme() {
    final index = _prefs.getInt(_themeKey) ?? 0;
    _themeMode = ThemeModeOption.values[index];
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeModeOption option) async {
    if (_themeMode == option) return;

    _themeMode = option;
    notifyListeners();
    await _prefs.setInt(_themeKey, option.index);
  }
}
