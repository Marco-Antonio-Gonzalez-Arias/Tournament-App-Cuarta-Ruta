import 'package:cuarta_ruta_app/core/config/theme/app_colors.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final TextStyle? textStyle;

  const ButtonWidget({
    super.key,
    required this.label,
    required this.onPressed,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil.of(context);

    return SizedBox(
      width: double.infinity,
      height: responsive.hp(9),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: AppColors.primaryGold,
            width: responsive.dp(0.3),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
        child: Text(
          label,
          style: textStyle ?? Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}