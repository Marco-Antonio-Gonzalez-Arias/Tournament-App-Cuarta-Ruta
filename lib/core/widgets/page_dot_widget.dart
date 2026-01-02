import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';

class PageDotWidget extends StatelessWidget {
  final bool isActive;

  const PageDotWidget({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.res.wp(1)),
      child: Container(
        width: context.res.dp(1),
        height: context.res.dp(1),
        decoration: _buildDecoration(theme),
      ),
    );
  }

  BoxDecoration _buildDecoration(ThemeData theme) {
    return BoxDecoration(
      shape: BoxShape.circle,
      color: isActive
          ? theme.colorScheme.primary
          : theme.colorScheme.primary.withAlpha(30),
    );
  }
}
