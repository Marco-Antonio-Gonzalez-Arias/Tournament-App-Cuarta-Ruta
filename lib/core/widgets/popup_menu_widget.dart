import 'package:flutter/material.dart';

class PopupMenuWidget<T> extends StatelessWidget {
  final List<PopupMenuEntry<T>> items;
  final ValueChanged<T> onSelected;
  final Widget icon;
  final Color? backgroundColor;
  final BoxConstraints? constraints;
  final Alignment itemAlignment;

  const PopupMenuWidget({
    super.key,
    required this.items,
    required this.onSelected,
    required this.icon,
    this.backgroundColor,
    this.constraints,
    this.itemAlignment = Alignment.centerLeft,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      color: backgroundColor ?? Theme.of(context).cardColor,
      constraints: constraints,
      tooltip: '',
      icon: icon,
      onSelected: onSelected,
      itemBuilder: (context) => items.map((entry) {
        if (entry is PopupMenuItem<T>) {
          return PopupMenuItem<T>(
            value: entry.value,
            enabled: entry.enabled,
            onTap: entry.onTap,
            child: Align(alignment: itemAlignment, child: entry.child),
          );
        }
        return entry;
      }).toList(),
    );
  }
}
