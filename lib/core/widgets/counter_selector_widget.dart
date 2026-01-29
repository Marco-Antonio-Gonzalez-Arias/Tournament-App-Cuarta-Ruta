import 'package:cuarta_ruta_app/core/utils/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/config/theme/app_colors.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';
import 'package:cuarta_ruta_app/core/widgets/gold_card_decorator.dart';

class CounterSelectorWidget extends StatelessWidget {
  final String label;
  final num count;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final TextStyle? textStyle;
  final num min;
  final num? max;
  final String? tooltip;

  const CounterSelectorWidget({
    super.key,
    required this.label,
    required this.count,
    required this.onIncrement,
    required this.onDecrement,
    this.textStyle,
    this.min = 1,
    this.max,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final canDecrement = count > min;
    final canIncrement = max == null || count < max!;

    return GoldCardDecorator(
      child: Row(
        children: [
          if (tooltip != null) _buildInfoIcon(context),
          Expanded(child: _buildLabelArea(context, theme)),
          _buildActionButton(
            context,
            Icons.remove,
            onDecrement,
            theme,
            canDecrement,
          ),
          _buildCounterArea(context, theme),
          _buildActionButton(
            context,
            Icons.add,
            onIncrement,
            theme,
            canIncrement,
          ),
        ],
      ),
    );
  }

  Widget _buildLabelArea(BuildContext context, ThemeData theme) => Container(
    height: context.res.hp(8),
    padding: EdgeInsets.only(left: context.res.wp(5)),
    alignment: Alignment.centerLeft,
    child: Text(label, style: textStyle ?? theme.textTheme.bodySmall),
  );

  Widget _buildInfoIcon(BuildContext context) {
    return Tooltip(
      message: tooltip!,
      triggerMode: TooltipTriggerMode.tap,
      showDuration: const Duration(seconds: 7),
      margin: EdgeInsets.symmetric(horizontal: context.res.wp(15)),
      padding: EdgeInsets.all(context.res.dp(1.5)),
      child: Container(
        width: context.res.wp(12),
        height: context.res.hp(8),
        color: AppColors.primaryColor,
        child: Icon(
          Icons.info_outline,
          size: context.res.dp(3.5),
          color: AppColors.getTextColor(context.isDark),
        ),
      ),
    );
  }

  Widget _buildCounterArea(BuildContext context, ThemeData theme) {
    final String formattedValue = (count % 1 == 0)
        ? count.toInt().toString()
        : count.toStringAsFixed(1);

    return Container(
      width: context.res.wp(15),
      height: context.res.hp(8),
      color: AppColors.primaryColor,
      alignment: Alignment.center,
      child: Text(
        formattedValue,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: AppColors.getTextColor(context.isDark),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    IconData icon,
    VoidCallback action,
    ThemeData theme,
    bool enabled,
  ) => GestureDetector(
    onTap: enabled ? action : null,
    child: Container(
      width: context.res.wp(12),
      height: context.res.hp(8),
      color: Colors.transparent,
      child: Icon(
        icon,
        color: enabled ? AppColors.primaryColor : theme.disabledColor,
        size: context.res.dp(3),
      ),
    ),
  );
}
