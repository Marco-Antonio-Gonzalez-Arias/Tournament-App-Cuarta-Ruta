import 'package:flutter/material.dart';

class AppColors {
  static const Color _gold = Color(0xFFC9A24D);
  static const Color _black = Color(0xFF1A1A1A);
  static const Color _white = Color(0xFFF2F2F2);

  static Brightness getBrightness(bool isDarkMode) =>
      isDarkMode ? Brightness.dark : Brightness.light;

  static Color get primaryColor => _gold;

  static Color get onPrimary => _black;

  static Color getTextColor(bool isDarkMode) => isDarkMode ? _white : _black;

  static Color getBackgroundColor(bool isDarkMode) =>
      isDarkMode ? _black : _white;
}
