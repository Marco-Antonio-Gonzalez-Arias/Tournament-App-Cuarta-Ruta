import 'package:flutter/material.dart';

class LogoImage extends StatelessWidget {
  final double height;

  const LogoImage({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    final assetPath = isDarkMode 
        ? 'assets/icon/icon_light.png' 
        : 'assets/icon/icon_black.png';

    return Image.asset(
      assetPath,
      height: height,
    );
  }
}