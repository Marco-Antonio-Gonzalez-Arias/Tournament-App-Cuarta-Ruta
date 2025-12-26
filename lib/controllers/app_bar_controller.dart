import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/utils/responsive.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isDarkMode;
  final VoidCallback onToggleDarkMode;

  const CustomAppBar({
    super.key,
    required this.isDarkMode,
    required this.onToggleDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return AppBar(
      leading: Padding(
        padding: EdgeInsets.all(responsive.dp(0.7)),
        child: Image.asset(
          isDarkMode 
            ? 'assets/icon/icon_light.png' 
            : 'assets/icon/icon_black.png'
        ),
      ),
      title: Text(
        "CUARTA RUTA",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: responsive.dp(2.5)
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
          iconSize: responsive.dp(3),
          onPressed: onToggleDarkMode,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}