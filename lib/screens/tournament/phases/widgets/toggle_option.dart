import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/utils/responsive.dart';
import 'package:cuarta_ruta_app/core/config/theme/app_colors.dart';

class ToggleOption extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const ToggleOption({super.key, required this.label, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryGold, width: 3),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: responsive.hp(8),
                color: AppColors.backgroundBlack,
                alignment: Alignment.center,
                child: Text(label, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primaryWhite)),
              ),
            ),
            Container(
              width: responsive.wp(20),
              height: responsive.hp(8),
              color: value ? AppColors.primaryGold : AppColors.backgroundBlack,
              child: value ? Icon(Icons.check, size: responsive.dp(4), color: AppColors.backgroundBlack) : null,
            ),
          ],
        ),
      ),
    );
  }
}