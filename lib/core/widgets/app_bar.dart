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

    // Padding lateral para alejar los elementos del borde amarillo
    return Padding(
      padding: EdgeInsets.only(
        top: responsive.dp(2),
        left: responsive.dp(1.5),
        right: responsive.dp(1.5),
      ),
      child: AppBar(
        leading: _buildLogo(responsive),
        title: _buildTitle(context),
        actions: [_buildThemeAction(responsive)],
        // Centrar elementos si es necesario
        centerTitle: true,
      ),
    );
  }

  Widget _buildLogo(Responsive responsive) {
    return LogoImage(height: responsive.dp(3));
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      "Votación de batallas de rap",
      style: Theme.of(context).textTheme.labelMedium,
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
