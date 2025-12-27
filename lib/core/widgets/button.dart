import 'package:cuarta_ruta_app/core/config/theme/app_colors.dart';
import 'package:cuarta_ruta_app/core/utils/responsive.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const Button({
    super.key, 
    required this.label, 
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return SizedBox(
      width: double.infinity,
      height: responsive.hp(9), // Altura responsiva
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: AppColors.primaryGold, 
            width: responsive.dp(0.3)
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}