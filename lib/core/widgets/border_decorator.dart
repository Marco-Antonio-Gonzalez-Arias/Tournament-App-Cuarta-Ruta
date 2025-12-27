import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/config/theme/app_colors.dart';
import 'package:cuarta_ruta_app/core/utils/responsive.dart';

class BorderDecorator extends StatelessWidget {
  final Widget child;

  const BorderDecorator({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

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