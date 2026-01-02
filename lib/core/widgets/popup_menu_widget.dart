import 'package:flutter/material.dart';

class PopupMenuWidget<T> extends StatelessWidget {
  final List<PopupMenuEntry<T>> items;
  final ValueChanged<T> onSelected;
  final Widget icon;
  final Color? backgroundColor;
  final BoxConstraints? constraints;
  final MainAxisAlignment itemAlignment;

  const PopupMenuWidget({
    super.key,
    required this.items,
    required this.onSelected,
    required this.icon,
    this.backgroundColor,
    this.constraints,
    this.itemAlignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      color: backgroundColor ?? Theme.of(context).cardColor,
      constraints: constraints,
      tooltip: '',
      icon: icon,
      onSelected: onSelected,
      itemBuilder: (context) => items,
    );
  }
}
