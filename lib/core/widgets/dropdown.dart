import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/utils/responsive.dart';
import 'package:cuarta_ruta_app/core/config/theme/app_colors.dart';

class Dropdown<T> extends StatelessWidget {
  final T value;
  final List<T> items;
  final String label;
  final ValueChanged<T?> onChanged;
  final String Function(T) itemLabelBuilder;
  final TextStyle? textStyle;

  const Dropdown({
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
    final res = Responsive.of(context);
    final theme = Theme.of(context);

    return Container(
      height: res.hp(8),
      decoration: _buildDecoration(res),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          dropdownColor: theme.scaffoldBackgroundColor,
          icon: _buildIcon(res),
          selectedItemBuilder: (context) => _buildSelectedItems(theme),
          items: _buildMenuItems(theme),
          onChanged: onChanged,
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration(Responsive res) {
    return BoxDecoration(
      border: Border.all(color: AppColors.primaryGold, width: res.dp(0.5)),
      borderRadius: BorderRadius.circular(res.dp(1)),
    );
  }

  Widget _buildIcon(Responsive res) {
    return Container(
      width: res.wp(20),
      height: res.hp(8),
      color: AppColors.primaryGold,
      child: Icon(
        Icons.arrow_drop_down,
        size: res.dp(5),
        color: AppColors.backgroundBlack,
      ),
    );
  }

  List<Widget> _buildSelectedItems(ThemeData theme) {
    final style = textStyle ??
        theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurface);

    return items
        .map((_) => Center(child: Text(label, style: style)))
        .toList();
  }

  List<DropdownMenuItem<T>> _buildMenuItems(ThemeData theme) {
    final style = textStyle ??
        theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurface);

    return items.map((item) {
      return DropdownMenuItem<T>(
        value: item,
        child: Text(itemLabelBuilder(item), style: style),
      );
    }).toList();
  }
}