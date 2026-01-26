import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cuarta_ruta_app/core/enums/phases_enum.dart';
import 'package:cuarta_ruta_app/core/services/impl/tournament_storage_service.dart';
import 'package:cuarta_ruta_app/models/impl/knockout_tournament_model.dart';
import 'package:cuarta_ruta_app/models/impl/league_tournament_model.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockPrefs;
  late TournamentStorageService service;
  const storageKey = 'tournaments';

  final t1 = KnockoutTournamentModel(
    name: 'Torneo A',
    startPhase: PhasesEnum.quarterFinals,
    hasThirdPlace: false,
    hasWildcard: false,
    pointsDifference: 2,
    replicaCount: 1,
    roundsConfig: {PhasesEnum.quarterFinals: 1},
  );

  final t2 = LeagueTournamentModel(
    name: 'Liga B',
    pointsDifference: 2,
    replicaCount: 0,
    participantCount: 6,
    battlesPerParticipant: 1,
    extraPlayer: false,
    roundsPerBattle: 1,
  );

  setUp(() {
    mockPrefs = MockSharedPreferences();
    service = TournamentStorageService(mockPrefs);
  });

  group('TournamentStorageService Tests', () {
    test('getAll should return empty list when no data exists', () async {
      when(() => mockPrefs.getString(storageKey)).thenReturn(null);

      final result = await service.getAll();

      expect(result, isEmpty);
    });

    test(
      'create should add a tournament and preserve its specific type',
      () async {
        when(() => mockPrefs.getString(storageKey)).thenReturn(null);
        when(
          () => mockPrefs.setString(storageKey, any()),
        ).thenAnswer((_) async => true);

        await service.create(t1);

        verify(
          () => mockPrefs.setString(
            storageKey,
            any(that: contains('"type":"knockout"')),
          ),
        ).called(1);
      },
    );

    test('getAll should correctly decode mixed tournament types', () async {
      final jsonList = jsonEncode([t1.toJson(), t2.toJson()]);
      when(() => mockPrefs.getString(storageKey)).thenReturn(jsonList);

      final result = await service.getAll();

      expect(result.length, 2);
      expect(result[0], isA<KnockoutTournamentModel>());
      expect(result[1], isA<LeagueTournamentModel>());
      expect(result[0].name, 'Torneo A');
      expect(result[1].name, 'Liga B');
    });

    test('delete should remove tournament by id', () async {
      final initialData = jsonEncode([t1.toJson()]);
      when(() => mockPrefs.getString(storageKey)).thenReturn(initialData);
      when(
        () => mockPrefs.setString(storageKey, any()),
      ).thenAnswer((_) async => true);

      await service.delete(t1.id);

      verify(() => mockPrefs.setString(storageKey, '[]')).called(1);
    });

    test('update should modify existing tournament data', () async {
      final initialData = jsonEncode([t1.toJson()]);
      final updatedTournament = t1.copyWith(name: 'Nombre Editado');
      when(() => mockPrefs.getString(storageKey)).thenReturn(initialData);
      when(
        () => mockPrefs.setString(storageKey, any()),
      ).thenAnswer((_) async => true);

      await service.update(updatedTournament);

      verify(
        () => mockPrefs.setString(
          storageKey,
          any(that: contains('Nombre Editado')),
        ),
      ).called(1);
    });
  });
}
