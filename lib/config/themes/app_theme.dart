import 'package:flutter/material.dart';

class AppTheme {
  final Color _colorSeed;
  final bool _isDarkMode;

  AppTheme({bool isDarkMode = false, required Color colorSeed})
    : _isDarkMode = isDarkMode,
      _colorSeed = colorSeed;

  ThemeData theme() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: _colorSeed,
      brightness: _isDarkMode ? Brightness.dark : Brightness.light,
    );
  }
}
