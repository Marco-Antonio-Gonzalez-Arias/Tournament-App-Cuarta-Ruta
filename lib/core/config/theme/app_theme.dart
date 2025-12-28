import 'package:cuarta_ruta_app/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/config/theme/app_colors.dart';

class AppTheme {
  final bool _isDarkMode;
  final Responsive _responsive;

  AppTheme({bool isDarkMode = false, required Responsive responsive})
    : _isDarkMode = isDarkMode,
      _responsive = responsive;

  ThemeData theme() {
    final brightness = _isDarkMode ? Brightness.dark : Brightness.light;
    final textColor = _isDarkMode
        ? AppColors.primaryWhite
        : AppColors.backgroundBlack;
    final backgroundColor = _isDarkMode
        ? AppColors.backgroundBlack
        : AppColors.primaryWhite;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: 'Bangers',
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryGold,
        brightness: brightness,
      ),
      textTheme: _buildTextTheme(textColor),
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        elevation: 0,
      ),
      splashColor: AppColors.primaryGold.withAlpha(12),
      highlightColor: AppColors.primaryGold.withAlpha(10),
    );
  }

  TextTheme _buildTextTheme(Color color) {
    return TextTheme(
      displayLarge: TextStyle(color: color, fontSize: _responsive.dp(8.5)),
      displayMedium: TextStyle(color: color, fontSize: _responsive.dp(8)),
      displaySmall: TextStyle(color: color, fontSize: _responsive.dp(7.5)),
      headlineLarge: TextStyle(color: color, fontSize: _responsive.dp(7)),
      headlineMedium: TextStyle(color: color, fontSize: _responsive.dp(6.5)),
      headlineSmall: TextStyle(color: color, fontSize: _responsive.dp(6)),
      titleLarge: TextStyle(color: color, fontSize: _responsive.dp(5.5)),
      titleMedium: TextStyle(color: color, fontSize: _responsive.dp(5)),
      titleSmall: TextStyle(color: color, fontSize: _responsive.dp(4.5)),
      bodyLarge: TextStyle(color: color, fontSize: _responsive.dp(4)),
      bodyMedium: TextStyle(color: color, fontSize: _responsive.dp(3.5)),
      bodySmall: TextStyle(color: color, fontSize: _responsive.dp(3)),
      labelLarge: TextStyle(color: color, fontSize: _responsive.dp(2.5)),
      labelMedium: TextStyle(color: color, fontSize: _responsive.dp(2)),
      labelSmall: TextStyle(color: color, fontSize: _responsive.dp(1.5)),
    );
  }
}
