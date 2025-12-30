import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/utils/responsive.dart';
import 'package:cuarta_ruta_app/core/config/theme/app_colors.dart';

class CounterSelector extends StatelessWidget {
  final String label;
  final int count;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final TextStyle? textStyle;
  final int min;
  final int? max;

  const CounterSelector({
    super.key,
    required this.label,
    required this.count,
    required this.onIncrement,
    required this.onDecrement,
    this.textStyle,
    this.min = 1,
    this.max,
  });

  @override
  Widget build(BuildContext context) {
    final res = Responsive.of(context);
    final theme = Theme.of(context);

    final canDecrement = count > min;
    final canIncrement = max == null || count < max!;

    return Container(
      decoration: _buildDecoration(res),
      child: Row(
        children: [
          _buildLabelArea(res, theme),
          _buildActionButton(Icons.remove, onDecrement, res, theme, canDecrement),
          _buildCounterArea(res, theme),
          _buildActionButton(Icons.add, onIncrement, res, theme, canIncrement),
        ],
      ),
    );
  }

  BoxDecoration _buildDecoration(Responsive res) {
    return BoxDecoration(
      border: Border.all(color: AppColors.primaryGold, width: res.dp(0.3)),
      borderRadius: BorderRadius.circular(res.dp(1)),
    );
  }

  Widget _buildLabelArea(Responsive res, ThemeData theme) {
    final style = textStyle ??
        theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurface);

    return Expanded(
      child: Container(
        height: res.hp(8),
        padding: EdgeInsets.only(left: res.wp(5)),
        alignment: Alignment.centerLeft,
        color: theme.scaffoldBackgroundColor,
        child: Text(label, style: style),
      ),
    );
  }

  Widget _buildCounterArea(Responsive res, ThemeData theme) {
    return Container(
      width: res.wp(15),
      height: res.hp(8),
      color: AppColors.primaryGold,
      alignment: Alignment.center,
      child: Text(
        '$count',
        style: theme.textTheme.bodyLarge?.copyWith(
          color: AppColors.backgroundBlack,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildActionButton(
    IconData icon,
    VoidCallback action,
    Responsive res,
    ThemeData theme,
    bool enabled,
  ) {
    return GestureDetector(
      onTap: enabled ? action : null,
      child: Container(
        width: res.wp(12),
        height: res.hp(8),
        color: theme.scaffoldBackgroundColor,
        child: Icon(
          icon,
          color: enabled ? AppColors.primaryGold : theme.disabledColor,
          size: res.dp(3),
        ),
      ),
    );
  }
}