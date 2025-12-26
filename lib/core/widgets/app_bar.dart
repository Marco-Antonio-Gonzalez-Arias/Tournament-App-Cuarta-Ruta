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
      title: _buildTitle(responsive),
      actions: [_buildThemeAction(responsive)],
    );
  }

  Widget _buildLogo(Responsive responsive) {
    final assetPath = isDarkMode 
        ? 'assets/icon/icon_light.png' 
        : 'assets/icon/icon_black.png';

    return Padding(
      padding: EdgeInsets.all(responsive.dp(0.7)),
      child: Image.asset(assetPath),
    );
  }

  Widget _buildTitle(Responsive responsive) {
    return Text(
      "CUARTA RUTA",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: responsive.dp(2.5),
      ),
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