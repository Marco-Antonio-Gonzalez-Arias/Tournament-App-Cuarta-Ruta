import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cuarta_ruta_app/core/enums/phases_enum.dart';
import 'package:cuarta_ruta_app/core/services/impl/tournament_storage_service.dart';
import 'package:cuarta_ruta_app/models/impl/tournament_model.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockPrefs;
  late TournamentStorageService service;
  const storageKey = 'tournaments';

  final t1 = TournamentModel(
    name: 'Torneo A',
    startPhase: PhasesEnum.cuartos,
    hasThirdPlace: false,
    hasReplica: false,
    roundsConfig: {},
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

    test('create should add a tournament to the existing list', () async {
      when(() => mockPrefs.getString(storageKey)).thenReturn(null);
      when(
        () => mockPrefs.setString(storageKey, any()),
      ).thenAnswer((_) async => true);

      await service.create(t1);

      verify(
        () => mockPrefs.setString(storageKey, any(that: contains(t1.name))),
      ).called(1);
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

    test('update should modify existing tournament', () async {
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
