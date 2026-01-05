import 'package:flutter/material.dart';

class LogoImageWidget extends StatelessWidget {
  final double height;
  final String lightAsset;
  final String darkAsset;

  const LogoImageWidget({
    super.key,
    required this.height,
    required this.lightAsset,
    required this.darkAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      _resolveAssetPath(context),
      height: height,
      fit: BoxFit.contain,
    );
  }

  String _resolveAssetPath(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode ? lightAsset : darkAsset;
  }
}
