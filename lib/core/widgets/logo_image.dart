import 'package:flutter/material.dart';

class LogoImage extends StatelessWidget {
  final double _height;

  const LogoImage({super.key, required double height}) : _height = height;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final assetPath = isDarkMode
        ? 'assets/icon/icon_light.png'
        : 'assets/icon/icon_black.png';

    return Image.asset(assetPath, height: _height, fit: BoxFit.contain);
  }
}
