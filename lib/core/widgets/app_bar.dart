import 'package:cuarta_ruta_app/core/widgets/logo_image.dart';
import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/utils/responsive.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isDarkMode;
  final VoidCallback onToggleDarkMode;

  const MyAppBar({
    super.key,
    required this.isDarkMode,
    required this.onToggleDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return AppBar(
      leading: _buildLogo(responsive),
      title: _buildTitle(context),
      actions: [_buildThemeAction(responsive)],
    );
  }

  Widget _buildLogo(Responsive responsive) {
    return Padding(
      padding: EdgeInsets.all(responsive.dp(0.7)),
      child: LogoImage(height: responsive.dp(4)),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      "Votación de batallas de rap",
      style: Theme.of(context).textTheme.labelLarge,
    );
  }

  Widget _buildThemeAction(Responsive responsive) {
    return IconButton(
      icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
      iconSize: responsive.dp(3),
      onPressed: onToggleDarkMode,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
