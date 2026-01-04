import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/widgets/app_bar_widget/widgets/theme_selector_action_widget.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final double height;

  const AppBarWidget({
    super.key,
    required this.height,
    this.title = "Votación de batallas de rap",
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      toolbarHeight: height,
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: theme.colorScheme.surfaceTint,
      backgroundColor: ElevationOverlay.applySurfaceTint(
        theme.colorScheme.surface,
        theme.colorScheme.surfaceTint,
        3.0,
      ),
      title: Text(
        title,
        style: theme.textTheme.labelMedium,
        textAlign: TextAlign.center,
      ),
      actions: [
        if (actions != null) ...actions!,
        const ThemeSelectorActionWidget(),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
