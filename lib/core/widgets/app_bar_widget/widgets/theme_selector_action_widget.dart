import 'package:cuarta_ruta_app/core/utils/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cuarta_ruta_app/core/config/theme/app_colors.dart';
import 'package:cuarta_ruta_app/core/providers/theme_provider.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';
import 'package:cuarta_ruta_app/core/widgets/popup_menu_widget.dart';

class ThemeSelectorActionWidget extends StatelessWidget {
  const ThemeSelectorActionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ThemeProvider>();

    return Center(
      child: PopupMenuWidget<ThemeModeOption>(
        icon: _buildIcon(context),
        onSelected: provider.setThemeMode,
        backgroundColor: _getBackgroundColor(context),
        constraints: _getConstraints(context),
        items: _buildMenuOptions(context, provider),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) => Icon(
    Icons.palette_outlined,
    size: context.res.dp(3),
    color: AppColors.primaryColor,
  );

  Color _getBackgroundColor(BuildContext context) =>
      AppColors.getBackgroundColor(context.isDark);

  BoxConstraints _getConstraints(BuildContext context) => BoxConstraints(
    minWidth: context.res.dp(18),
    maxWidth: context.res.dp(22),
  );

  List<PopupMenuItem<ThemeModeOption>> _buildMenuOptions(
    BuildContext context,
    ThemeProvider provider,
  ) => [
    _buildItem(
      context,
      ThemeModeOption.system,
      'Predeterminado del Sistema',
      provider,
    ),
    _buildItem(context, ThemeModeOption.light, 'Claro', provider),
    _buildItem(context, ThemeModeOption.dark, 'Oscuro', provider),
  ];

  PopupMenuItem<ThemeModeOption> _buildItem(
    BuildContext context,
    ThemeModeOption value,
    String text,
    ThemeProvider provider,
  ) {
    final isSelected = value == provider.themeMode;
    return PopupMenuItem(
      value: value,
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? AppColors.primaryColor : null,
        ),
      ),
    );
  }
}
