import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  bool get isDark => Theme.of(this).brightness.isDark;
}

extension BrightnessExtension on Brightness {
  bool get isDark => this == Brightness.dark;
}
