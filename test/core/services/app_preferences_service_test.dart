import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cuarta_ruta_app/core/services/impl/app_preferences_service.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockPrefs;
  late AppPreferencesService service;
  const sortKey = 'tournament_sort_option';

  setUp(() {
    mockPrefs = MockSharedPreferences();
    service = AppPreferencesService(mockPrefs);
  });

  group('AppPreferencesService Tests', () {
    test(
      'saveSortOption should call setString with correct key and value',
      () async {
        when(
          () => mockPrefs.setString(any(), any()),
        ).thenAnswer((_) async => true);

        await service.saveSortOption('nameAsc');

        verify(() => mockPrefs.setString(sortKey, 'nameAsc')).called(1);
      },
    );

    test('getSortOption should return value from SharedPreferences', () {
      when(() => mockPrefs.getString(sortKey)).thenReturn('dateNewest');

      final result = service.getSortOption();

      expect(result, 'dateNewest');
      verify(() => mockPrefs.getString(sortKey)).called(1);
    });

    test('getSortOption should return null if key does not exist', () {
      when(() => mockPrefs.getString(any())).thenReturn(null);

      final result = service.getSortOption();

      expect(result, isNull);
    });
  });
}
