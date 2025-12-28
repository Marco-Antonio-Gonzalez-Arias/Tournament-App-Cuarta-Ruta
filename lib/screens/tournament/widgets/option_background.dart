import 'package:flutter/material.dart';

class OptionBackground extends StatelessWidget {
  final String _imagePath;

  const OptionBackground({
    super.key,
    required String imagePath,
  }) : _imagePath = imagePath;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(_imagePath, fit: BoxFit.cover),
      ],
    );
  }
}