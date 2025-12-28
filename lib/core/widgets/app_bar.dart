import 'package:cuarta_ruta_app/core/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/utils/responsive.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? _title;

  const MyAppBar({
    super.key,
    String? title,
  }) : _title = title;

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final responsive = Responsive.of(context);

    return Padding(
      padding: EdgeInsets.only(
        top: responsive.dp(2),
        left: responsive.dp(1.5),
        right: responsive.dp(1.5),
      ),
      child: AppBar(
        // Si _title es nulo, usa el por defecto
        title: Text(
          _title ?? "Votación de batallas de rap",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        actions: [
          IconButton(
            icon: Icon(themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            iconSize: responsive.dp(3),
            onPressed: themeProvider.toggleTheme,
          )
        ],
        centerTitle: true,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20); 
}