import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/widgets/bordered_text_widget.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';
import 'package:cuarta_ruta_app/core/config/theme/app_colors.dart';

class MenuOptionWidget extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;

  const MenuOptionWidget({
    super.key,
    required this.imagePath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final res = ResponsiveUtil.of(context);
    final double padding = res.dp(1.3);

    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: ClipRect(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(imagePath, fit: BoxFit.cover),
              Center(
                child: IgnorePointer(
                  child: BorderedTextWidget(
                    text: label,
                    style: Theme.of(context).textTheme.displayLarge,
                    strokeWidth: res.dp(2),
                    strokeColor: AppColors.backgroundBlack,
                    fillColor: AppColors.primaryGold,
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(onTap: onTap),
              ),
            ],
          ),
        ),
      ),
    );
  }
}