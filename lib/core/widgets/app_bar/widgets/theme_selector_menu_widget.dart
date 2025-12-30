import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/config/theme/app_colors.dart';
import 'package:cuarta_ruta_app/core/providers/theme_provider.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';

class ThemeSelectorMenuWidget extends StatelessWidget {
  final ThemeProvider themeProvider;

  const ThemeSelectorMenuWidget({super.key, required this.themeProvider});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil.of(context);
    final isDark = themeProvider.isDarkMode(context);

    return PopupMenuButton<ThemeModeOption>(
      color: isDark ? AppColors.backgroundBlack : AppColors.primaryWhite,
      constraints: BoxConstraints(
        minWidth: responsive.dp(18),
        maxWidth: responsive.dp(22),
      ),
      tooltip: '',
      icon: Icon(
        Icons.palette_outlined,
        size: responsive.dp(3),
        color: AppColors.primaryGold,
      ),
      onSelected: themeProvider.setThemeMode,
      itemBuilder: (context) => [
        _buildMenuItem(ThemeModeOption.system, 'Predeterminado del sistema', context),
        _buildMenuItem(ThemeModeOption.light, 'Modo claro', context),
        _buildMenuItem(ThemeModeOption.dark, 'Modo oscuro', context),
      ],
    );
  }

  PopupMenuItem<ThemeModeOption> _buildMenuItem(
    ThemeModeOption value,
    String text,
    BuildContext context,
  ) {
    final isSelected = value == themeProvider.themeMode;
    
    return PopupMenuItem(
      value: value,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? AppColors.primaryGold : null,
                ),
          ),
        ],
      ),
    );
  }
}