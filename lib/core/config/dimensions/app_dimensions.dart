import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';

class AppDimensions {
  static double appBarHeight(ResponsiveUtil res) =>
      kToolbarHeight + res.hp(1.5);
}
