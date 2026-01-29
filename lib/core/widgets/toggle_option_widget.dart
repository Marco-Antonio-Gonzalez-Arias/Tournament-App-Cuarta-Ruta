import 'package:cuarta_ruta_app/core/utils/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/config/theme/app_colors.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';
import 'package:cuarta_ruta_app/core/widgets/gold_card_decorator.dart';

class ToggleOptionWidget extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final TextStyle? textStyle;
  final String? tooltip;

  const ToggleOptionWidget({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.textStyle,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return GoldCardDecorator(
      child: Row(
        children: [
          if (tooltip != null) _buildInfoIcon(context),
          Expanded(child: _buildLabel(context)),
          _buildToggle(context),
        ],
      ),
    );
  }

  Widget _buildLabel(BuildContext context) => Container(
    height: context.res.hp(8),
    alignment: Alignment.center,
    child: Text(
      label,
      style: textStyle ?? Theme.of(context).textTheme.bodySmall,
    ),
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

  Widget _buildToggle(BuildContext context) => GestureDetector(
    onTap: () => onChanged(!value),
    child: Container(
      width: context.res.wp(20),
      height: context.res.hp(8),
      color: value ? AppColors.primaryColor : Colors.transparent,
      child: value ? _buildCheckIcon(context) : null,
    ),
  );

  Widget _buildCheckIcon(BuildContext context) {
    return Icon(
      Icons.check,
      size: context.res.dp(4),
      color: AppColors.getTextColor(context.isDark),
    );
  }
}
