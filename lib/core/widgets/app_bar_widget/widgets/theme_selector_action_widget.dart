import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cuarta_ruta_app/core/providers/theme_provider.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';
import 'package:cuarta_ruta_app/core/widgets/popup_menu_widget.dart';

class ThemeSelectorActionWidget extends StatelessWidget {
  const ThemeSelectorActionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ThemeProvider>();

    return PopupMenuWidget<ThemeModeOption>(
      icon: Icon(Icons.palette_outlined, size: context.res.dp(3)),
      initialValue: provider.themeMode,
      onSelected: provider.setThemeMode,
      itemAlignment: Alignment.centerRight,
      constraints: BoxConstraints(
        minWidth: context.res.dp(18),
        maxWidth: context.res.dp(22),
      ),
      textStyle: Theme.of(
        context,
      ).textTheme.labelSmall?.copyWith(fontSize: context.res.dp(1.5)),
      items: const [
        PopupMenuItem(
          value: ThemeModeOption.system,
          child: Text('Predeterminado del Sistema'),
        ),
        PopupMenuItem(value: ThemeModeOption.light, child: Text('Claro')),
        PopupMenuItem(value: ThemeModeOption.dark, child: Text('Oscuro')),
      ],
    );
  }
}
