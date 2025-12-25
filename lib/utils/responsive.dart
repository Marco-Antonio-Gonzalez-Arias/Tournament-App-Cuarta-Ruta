import 'package:flutter/material.dart';
import 'dart:math' as math;

class Responsive {
  late double _width, _height, _diagonal;

  double get width => _width;
  double get height => _height;
  double get diagonal => _diagonal;

  static Responsive of(BuildContext context) => Responsive(context);

  Responsive(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    _width = size.width;
    _height = size.height;
    _diagonal = math.sqrt(math.pow(_width, 2) + math.pow(_height, 2)); // Pythagorean theorem
  }

  double wp(double percentage) => _width * (percentage / 100);
  double hp(double percentage) => _height * (percentage / 100);
  double dp(double percentage) => _diagonal * (percentage / 100);
}