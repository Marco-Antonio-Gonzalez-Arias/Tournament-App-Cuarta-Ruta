import 'package:flutter/material.dart';

class BorderedTextWidget extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final double strokeWidth;
  final Color strokeColor;
  final Color fillColor;

  const BorderedTextWidget({
    super.key,
    required this.text,
    required this.strokeWidth,
    required this.strokeColor,
    required this.fillColor,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [_buildStrokeText(), _buildFillText()]);
  }

  Widget _buildStrokeText() => Text(
    text,
    style: style?.copyWith(
      foreground: Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..color = strokeColor,
    ),
  );

  Widget _buildFillText() =>
      Text(text, style: style?.copyWith(color: fillColor));
}
