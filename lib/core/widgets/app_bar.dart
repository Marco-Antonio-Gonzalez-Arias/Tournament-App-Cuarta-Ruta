import 'package:cuarta_ruta_app/core/widgets/logo_image.dart';
import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/utils/responsive.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool _isDarkMode;
  final VoidCallback _onToggleDarkMode;
  final Responsive _responsive;

  const MyAppBar({
    super.key,
    required bool isDarkMode,
    required VoidCallback onToggleDarkMode,
    required Responsive responsive,
  }) : _isDarkMode = isDarkMode,
       _onToggleDarkMode = onToggleDarkMode,
       _responsive = responsive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: _responsive.dp(2),
        left: _responsive.dp(1.5),
        right: _responsive.dp(1.5),
      ),
      child: AppBar(
        title: _buildTitle(context),
        actions: [_buildThemeAction()],
        centerTitle: true,
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      "Votación de batallas de rap",
      style: Theme.of(context).textTheme.labelMedium,
    );
  }

  Widget _buildThemeAction() {
    return IconButton(
      icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
      iconSize: _responsive.dp(3),
      onPressed: _onToggleDarkMode,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + _responsive.dp(2));
}
