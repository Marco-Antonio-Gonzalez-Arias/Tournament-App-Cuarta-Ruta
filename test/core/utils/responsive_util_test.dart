import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';

void main() {
  group('ResponsiveUtil Tests', () {
    const testSize = Size(100, 200);
    final responsive = ResponsiveUtil.fromSize(testSize);

    test('wp() should return correct width percentage', () {
      expect(responsive.wp(50), 50.0);
      expect(responsive.wp(10), 10.0);
    });

    test('hp() should return correct height percentage', () {
      expect(responsive.hp(50), 100.0);
      expect(responsive.hp(25), 50.0);
    });

    test('dp() should return correct diagonal percentage', () {
      expect(responsive.dp(10), closeTo(22.36, 0.01));
    });
  });
}
