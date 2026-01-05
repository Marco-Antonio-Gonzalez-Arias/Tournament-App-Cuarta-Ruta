import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cuarta_ruta_app/core/providers/theme_provider.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockPrefs;
  late ThemeProvider themeProvider;

  setUp(() {
    mockPrefs = MockSharedPreferences();
    when(() => mockPrefs.getInt(any())).thenReturn(null);
    themeProvider = ThemeProvider(mockPrefs);
  });

  group('ThemeProvider Tests', () {
    test('Should load default theme (system) if no preference exists', () {
      expect(themeProvider.themeMode, ThemeModeOption.system);
    });

    test('setThemeMode should update state and save to prefs', () async {
      when(() => mockPrefs.setInt(any(), any())).thenAnswer((_) async => true);

      await themeProvider.setThemeMode(ThemeModeOption.dark);

      expect(themeProvider.themeMode, ThemeModeOption.dark);
      verify(
        () => mockPrefs.setInt('themeMode', ThemeModeOption.dark.index),
      ).called(1);
    });

    test(
      'calculateDarkMode should respect system brightness when mode is system',
      () {
        expect(themeProvider.calculateDarkMode(Brightness.dark), isTrue);
        expect(themeProvider.calculateDarkMode(Brightness.light), isFalse);
      },
    );

    test(
      'calculateDarkMode should ignore system brightness when mode is fixed',
      () async {
        when(
          () => mockPrefs.setInt(any(), any()),
        ).thenAnswer((_) async => true);

        await themeProvider.setThemeMode(ThemeModeOption.light);

        expect(themeProvider.calculateDarkMode(Brightness.dark), isFalse);
      },
    );
  });
}
