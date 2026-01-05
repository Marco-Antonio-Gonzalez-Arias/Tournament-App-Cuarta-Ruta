import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cuarta_ruta_app/core/utils/theme_extension.dart';

void main() {
  group('BrightnessExtension Tests', () {
    test('isDark should return true when brightness is dark', () {
      const brightness = Brightness.dark;
      expect(brightness.isDark, isTrue);
    });

    test('isDark should return false when brightness is light', () {
      const brightness = Brightness.light;
      expect(brightness.isDark, isFalse);
    });
  });
}
