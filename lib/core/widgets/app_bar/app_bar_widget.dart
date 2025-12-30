import 'package:cuarta_ruta_app/core/providers/theme_provider.dart';
import 'package:cuarta_ruta_app/core/widgets/app_bar/widgets/theme_selector_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';
import 'package:provider/provider.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? _title;

  const AppBarWidget({super.key, String? title}) : _title = title;

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final responsive = ResponsiveUtil.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: responsive.dp(2),
        horizontal: responsive.dp(1.5),
      ),
      child: AppBar(
        title: Text(
          _title ?? "Votación de batallas de rap",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        actions: [ThemeSelectorMenuWidget(themeProvider: themeProvider)],
        centerTitle: true,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);
}