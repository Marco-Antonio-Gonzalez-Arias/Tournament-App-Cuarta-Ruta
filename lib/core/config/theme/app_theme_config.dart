import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';
import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/config/theme/app_colors.dart';

class AppThemeConfig {
  final bool _isDarkMode;
  final ResponsiveUtil _responsive;

  AppThemeConfig({bool isDarkMode = false, required ResponsiveUtil responsive})
    : _isDarkMode = isDarkMode,
      _responsive = responsive;

  ThemeData theme() {
    final brightness = AppColors.getBrightness(_isDarkMode);
    final textColor = AppColors.getTextColor(_isDarkMode);
    final backgroundColor = AppColors.getBackgroundColor(_isDarkMode);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: 'Bangers',
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryColor,
        brightness: brightness,
      ),
      textTheme: _buildTextTheme(textColor),
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        elevation: 0,
      ),
      splashColor: AppColors.primaryColor.withAlpha(12),
      highlightColor: AppColors.primaryColor.withAlpha(10),
      dividerColor: AppColors.primaryColor,
      dividerTheme: DividerThemeData(color: AppColors.primaryColor),
    );
  }

  TextTheme _buildTextTheme(Color color) {
    TextStyle style(double size) =>
        TextStyle(color: color, fontSize: _responsive.dp(size));

    return TextTheme(
      displayLarge: style(8.5),
      displayMedium: style(8),
      displaySmall: style(7.5),
      headlineLarge: style(7),
      headlineMedium: style(6.5),
      headlineSmall: style(6),
      titleLarge: style(5.5),
      titleMedium: style(5),
      titleSmall: style(4.5),
      bodyLarge: style(4),
      bodyMedium: style(3.5),
      bodySmall: style(3),
      labelLarge: style(2.5),
      labelMedium: style(2),
      labelSmall: style(1.5),
    );
  }
}
