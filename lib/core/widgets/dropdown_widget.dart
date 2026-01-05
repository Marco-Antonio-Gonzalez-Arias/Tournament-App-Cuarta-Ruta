import 'package:cuarta_ruta_app/core/utils/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/config/theme/app_colors.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';
import 'package:cuarta_ruta_app/core/widgets/gold_card_decorator.dart';

class DropdownWidget<T> extends StatelessWidget {
  final T value;
  final List<T> items;
  final String label;
  final ValueChanged<T?> onChanged;
  final String Function(T) itemLabelBuilder;
  final TextStyle? textStyle;

  const DropdownWidget({
    super.key,
    required this.value,
    required this.items,
    required this.label,
    required this.onChanged,
    required this.itemLabelBuilder,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return GoldCardDecorator(
      child: SizedBox(
        height: context.res.hp(8),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            value: value,
            isExpanded: true,
            dropdownColor: Theme.of(context).scaffoldBackgroundColor,
            icon: _buildGoldenIcon(context),
            selectedItemBuilder: (context) => _buildSelectedItems(context),
            items: _buildMenuItems(context),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }

  Widget _buildGoldenIcon(BuildContext context) {
    return Container(
      width: context.res.wp(20),
      height: double.infinity,
      color: AppColors.primaryColor,
      child: Icon(
        Icons.arrow_drop_down,
        size: context.res.dp(5),
        color: AppColors.getTextColor(context.isDark),
      ),
    );
  }

  List<Widget> _buildSelectedItems(BuildContext context) => items
      .map(
        (_) => Center(
          child: Text(label, style: textStyle ?? _defaultStyle(context)),
        ),
      )
      .toList();

  List<DropdownMenuItem<T>> _buildMenuItems(BuildContext context) => items
      .map(
        (item) => DropdownMenuItem<T>(
          value: item,
          child: Text(itemLabelBuilder(item), style: _defaultStyle(context)),
        ),
      )
      .toList();

  TextStyle? _defaultStyle(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall;
}
