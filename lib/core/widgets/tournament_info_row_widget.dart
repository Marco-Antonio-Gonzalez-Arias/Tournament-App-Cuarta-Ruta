import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';

class TournamentInfoRowWidget extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;
  final EdgeInsetsGeometry? padding;

  const TournamentInfoRowWidget({
    super.key,
    required this.label,
    required this.value,
    this.labelStyle,
    this.valueStyle,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(vertical: context.res.hp(0.3)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildText(label, labelStyle ?? _getDefaultLabelStyle(context)),
          _buildText(value, valueStyle ?? _getDefaultValueStyle(context)),
        ],
      ),
    );
  }

  Widget _buildText(String text, TextStyle? style) => Text(text, style: style);

  TextStyle? _getDefaultLabelStyle(BuildContext context) =>
      Theme.of(context).textTheme.labelMedium;

  TextStyle? _getDefaultValueStyle(BuildContext context) {
    final theme = Theme.of(context);
    return theme.textTheme.labelMedium?.copyWith(
      color: theme.colorScheme.primary,
    );
  }
}
