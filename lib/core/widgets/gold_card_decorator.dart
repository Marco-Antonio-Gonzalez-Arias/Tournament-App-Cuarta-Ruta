import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/config/theme/app_colors.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';

class GoldCardDecorator extends StatelessWidget {
  final Widget child;
  final Color? borderColor;
  final double? borderRadius;
  final double? borderWidth;

  const GoldCardDecorator({
    super.key,
    required this.child,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(decoration: _buildDecoration(context), child: child);
  }

  BoxDecoration _buildDecoration(BuildContext context) {
    return BoxDecoration(
      border: Border.all(
        color: borderColor ?? AppColors.primaryColor,
        width: borderWidth ?? context.res.dp(0.2),
      ),
      borderRadius: BorderRadius.circular(borderRadius ?? context.res.dp(1)),
    );
  }
}
