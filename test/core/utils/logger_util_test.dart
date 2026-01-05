import 'package:flutter_test/flutter_test.dart';
import 'package:cuarta_ruta_app/core/utils/logger_util.dart';

void main() {
  group('LoggerUtil Tests', () {
    test('info() should execute without errors', () {
      expect(() => LoggerUtil.info('Test info message'), returnsNormally);
    });

    test('error() should execute without errors', () {
      expect(() => LoggerUtil.error('Test error message'), returnsNormally);
    });

    test('warning() should execute without errors', () {
      expect(() => LoggerUtil.warning('Test warning message'), returnsNormally);
    });

    test('debug() should execute without errors', () {
      expect(() => LoggerUtil.debug('Test debug message'), returnsNormally);
    });
  });
}
