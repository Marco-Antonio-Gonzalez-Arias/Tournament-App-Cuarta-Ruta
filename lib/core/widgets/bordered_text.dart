import 'package:flutter/material.dart';

class BorderedText extends StatelessWidget {
  final String _text;
  final TextStyle? _style;
  final double _strokeWidth;
  final Color _strokeColor;
  final Color _fillColor;

  const BorderedText({
    super.key,
    required String text,
    TextStyle? style,
    required double strokeWidth,
    required Color strokeColor,
    required Color fillColor,
  })  : _text = text,
        _style = style,
        _strokeWidth = strokeWidth,
        _strokeColor = strokeColor,
        _fillColor = fillColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          _text,
          style: _style?.copyWith(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = _strokeWidth
              ..color = _strokeColor,
          ),
        ),
        Text(
          _text,
          style: _style?.copyWith(color: _fillColor),
        ),
      ],
    );
  }
}