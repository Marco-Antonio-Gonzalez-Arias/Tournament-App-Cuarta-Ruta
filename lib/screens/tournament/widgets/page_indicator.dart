import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/config/theme/app_colors.dart';

class PageIndicator extends StatelessWidget {
  final bool isActive;

  const PageIndicator({
    super.key,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive
            ? AppColors.primaryWhite
            : AppColors.primaryWhite.withAlpha(30),
      ),
    );
  }
}