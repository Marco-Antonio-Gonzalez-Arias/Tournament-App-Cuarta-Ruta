import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cuarta_ruta_app/core/services/impl/tournament_progress_storage_service.dart';
import 'package:cuarta_ruta_app/models/impl/knockout_progress_model.dart';
import 'package:cuarta_ruta_app/models/impl/league_progress_model.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockPrefs;
  late TournamentProgressStorageService service;
  const storageKey = 'tournaments_progress';

  final knockoutProgress = KnockoutProgressModel(
    id: 'kp1',
    tournamentId: 't1',
    participants: [],
    matchesByPhase: {},
  );

  final leagueProgress = LeagueProgressModel(
    id: 'lp1',
    tournamentId: 't2',
    participants: [],
    matchesByJourney: {},
  );

  setUp(() {
    mockPrefs = MockSharedPreferences();
    service = TournamentProgressStorageService(mockPrefs);
  });

  group('TournamentProgressStorageService Tests', () {
    test('getAll should return empty list when no data exists', () async {
      when(() => mockPrefs.getString(storageKey)).thenReturn(null);

      final result = await service.getAll();

      expect(result, isEmpty);
    });

    test('save should add new progress and preserve type', () async {
      when(() => mockPrefs.getString(storageKey)).thenReturn(null);
      when(
        () => mockPrefs.setString(storageKey, any()),
      ).thenAnswer((_) async => true);

      await service.save(knockoutProgress);

      verify(
        () => mockPrefs.setString(
          storageKey,
          any(that: contains('"type":"knockout"')),
        ),
      ).called(1);
    });

    test('save should update existing progress if ID matches', () async {
      final initialData = jsonEncode([knockoutProgress.toJson()]);
      final updatedProgress = knockoutProgress.copyWith(isCompleted: true);

      when(() => mockPrefs.getString(storageKey)).thenReturn(initialData);
      when(
        () => mockPrefs.setString(storageKey, any()),
      ).thenAnswer((_) async => true);

      await service.save(updatedProgress);

      verify(
        () => mockPrefs.setString(
          storageKey,
          any(that: contains('"isCompleted":true')),
        ),
      ).called(1);
    });

    test('getByTournamentId should return correct progress', () async {
      final data = jsonEncode([
        knockoutProgress.toJson(),
        leagueProgress.toJson(),
      ]);
      when(() => mockPrefs.getString(storageKey)).thenReturn(data);

      final result = await service.getByTournamentId('t2');

      expect(result, isA<LeagueProgressModel>());
      expect(result?.tournamentId, 't2');
    });

    test('delete should remove specific progress by id', () async {
      final data = jsonEncode([knockoutProgress.toJson()]);
      when(() => mockPrefs.getString(storageKey)).thenReturn(data);
      when(
        () => mockPrefs.setString(storageKey, any()),
      ).thenAnswer((_) async => true);

      await service.delete('kp1');

      verify(() => mockPrefs.setString(storageKey, '[]')).called(1);
    });

    test('decode should handle mixed types in storage', () async {
      final data = jsonEncode([
        knockoutProgress.toJson(),
        leagueProgress.toJson(),
      ]);
      when(() => mockPrefs.getString(storageKey)).thenReturn(data);

      final result = await service.getAll();

      expect(result.length, 2);
      expect(result[0], isA<KnockoutProgressModel>());
      expect(result[1], isA<LeagueProgressModel>());
    });
  });
}
