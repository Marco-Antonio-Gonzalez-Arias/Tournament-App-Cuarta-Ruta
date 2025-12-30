import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/utils/responsive.dart';
import 'package:cuarta_ruta_app/core/config/theme/app_colors.dart';

class ToggleOption extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final TextStyle? textStyle;

  const ToggleOption({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final res = Responsive.of(context);
    final theme = Theme.of(context);

    return Container(
      decoration: _buildDecoration(res),
      child: Row(
        children: [
          _buildLabelArea(res, theme),
          _buildToggleArea(res, theme),
        ],
      ),
    );
  }

  BoxDecoration _buildDecoration(Responsive res) {
    return BoxDecoration(
      border: Border.all(
        color: AppColors.primaryGold,
        width: res.dp(0.3),
      ),
      borderRadius: BorderRadius.circular(res.dp(1)),
    );
  }

  Widget _buildLabelArea(Responsive res, ThemeData theme) {
    final style = textStyle ?? 
        theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurface);

    return Expanded(
      child: Container(
        height: res.hp(8),
        color: theme.scaffoldBackgroundColor,
        alignment: Alignment.center,
        child: Text(label, style: style),
      ),
    );
  }

  Widget _buildToggleArea(Responsive res, ThemeData theme) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        width: res.wp(20),
        height: res.hp(8),
        color: value ? AppColors.primaryGold : theme.scaffoldBackgroundColor,
        child: value ? _buildCheckIcon(res) : null,
      ),
    );
  }

  Widget _buildCheckIcon(Responsive res) {
    return Icon(
      Icons.check,
      size: res.dp(4),
      color: AppColors.backgroundBlack,
    );
  }
}