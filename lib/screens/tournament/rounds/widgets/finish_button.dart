import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/utils/responsive.dart';
import 'package:cuarta_ruta_app/core/config/theme/app_colors.dart';

class FinishButton extends StatelessWidget {
  final VoidCallback onPressed;
  const FinishButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final res = Responsive.of(context);
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onPressed,
            child: Container(
              height: res.hp(8),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryGold, width: 3),
                borderRadius: BorderRadius.circular(8),
                color: AppColors.backgroundBlack,
              ),
              alignment: Alignment.center,
              child: Text('CREAR', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primaryWhite)),
            ),
          ),
        ),
        SizedBox(width: res.wp(3)),
        GestureDetector(
          onTap: onPressed,
          child: Container(
            width: res.wp(20),
            height: res.hp(8),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryGold, width: 3),
              borderRadius: BorderRadius.circular(8),
              color: AppColors.primaryGold,
            ),
            child: Icon(Icons.arrow_forward, size: res.dp(4), color: AppColors.backgroundBlack),
          ),
        ),
      ],
    );
  }
}