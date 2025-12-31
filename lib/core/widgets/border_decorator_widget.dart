import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/config/theme/app_colors.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';

class BorderDecoratorWidget extends StatelessWidget {
  final Widget child;

  const BorderDecoratorWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil.of(context);

    return SafeArea(
      child: Stack(
        children: [
          child,
          IgnorePointer(
            child: RepaintBoundary(
              child: Padding(
                padding: EdgeInsets.all(responsive.dp(1)),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.primaryGold,
                      width: responsive.dp(0.3),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}