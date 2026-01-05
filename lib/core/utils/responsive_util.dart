import 'package:flutter/material.dart';
import 'dart:math' as math;

class ResponsiveUtil {
  final double width;
  final double height;
  final double diagonal;

  const ResponsiveUtil._({
    required this.width,
    required this.height,
    required this.diagonal,
  });

  factory ResponsiveUtil.of(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final diagonal = math.sqrt(
      math.pow(size.width, 2) + math.pow(size.height, 2),
    );

    return ResponsiveUtil._(
      width: size.width,
      height: size.height,
      diagonal: diagonal,
    );
  }

  double wp(double percentage) => width * (percentage / 100);
  double hp(double percentage) => height * (percentage / 100);
  double dp(double percentage) => diagonal * (percentage / 100);
}

extension ResponsiveContext on BuildContext {
  ResponsiveUtil get res => ResponsiveUtil.of(this);
}
