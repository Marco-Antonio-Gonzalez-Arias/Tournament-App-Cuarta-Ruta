import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/config/theme/app_colors.dart';

class PopupMenuWidget<T> extends StatelessWidget {
  final List<PopupMenuEntry<T>> items;
  final ValueChanged<T> onSelected;
  final Widget icon;
  final T? initialValue;
  final Color? backgroundColor;
  final BoxConstraints? constraints;
  final Alignment itemAlignment;
  final TextStyle? textStyle;

  const PopupMenuWidget({
    super.key,
    required this.items,
    required this.onSelected,
    required this.icon,
    this.initialValue,
    this.backgroundColor,
    this.constraints,
    this.itemAlignment = Alignment.centerLeft,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      initialValue: initialValue,
      color: backgroundColor ?? Theme.of(context).cardColor,
      constraints: constraints,
      tooltip: '',
      icon: icon,
      onSelected: onSelected,
      itemBuilder: (context) => items.map((entry) {
        if (entry is PopupMenuItem<T>) {
          final isSelected = entry.value == initialValue;

          return PopupMenuItem<T>(
            value: entry.value,
            enabled: entry.enabled,
            onTap: entry.onTap,
            child: Align(
              alignment:
                  itemAlignment,
              child: DefaultTextStyle.merge(
                style: (textStyle ?? const TextStyle()).copyWith(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? AppColors.primaryColor : null,
                ),
                child: entry.child ?? const SizedBox.shrink(),
              ),
            ),
          );
        }
        return entry;
      }).toList(),
    );
  }
}
