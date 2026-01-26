import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cuarta_ruta_app/core/providers/tournament_list_provider.dart';
import 'package:cuarta_ruta_app/core/services/app_preferences_base.dart';
import 'package:cuarta_ruta_app/core/services/tournament_storage_base.dart';
import 'package:cuarta_ruta_app/core/enums/tournament_sort_option_enum.dart';
import 'package:cuarta_ruta_app/core/enums/phases_enum.dart';
import 'package:cuarta_ruta_app/models/impl/knockout_tournament_model.dart';
import 'package:cuarta_ruta_app/models/impl/league_tournament_model.dart';

class MockTournamentStorage extends Mock implements TournamentStorageBase {}

class MockAppPreferences extends Mock implements AppPreferencesBase {}

void main() {
  late MockTournamentStorage mockStorage;
  late MockAppPreferences mockPrefs;
  late TournamentListProvider provider;

  final t1 = KnockoutTournamentModel(
    name: 'Árbol',
    startPhase: PhasesEnum.quarterFinals,
    hasThirdPlace: false,
    hasWildcard: false,
    pointsDifference: 2,
    replicaCount: 1,
    roundsConfig: {},
  );

  final t2 = LeagueTournamentModel(
    name: 'Zorro',
    pointsDifference: 2,
    replicaCount: 0,
    participantCount: 8,
    battlesPerParticipant: 2,
    extraPlayer: false,
    roundsPerBattle: 1,
  );

  setUp(() {
    mockStorage = MockTournamentStorage();
    mockPrefs = MockAppPreferences();

    when(() => mockPrefs.getSortOption()).thenReturn(null);
    provider = TournamentListProvider(mockStorage, mockPrefs);
  });

  group('TournamentListProvider Tests', () {
    test(
      'loadTournaments should update list with mixed tournament types',
      () async {
        when(() => mockStorage.getAll()).thenAnswer((_) async => [t1, t2]);

        await provider.loadTournaments();

        expect(provider.tournaments.length, 2);
        expect(provider.tournaments[0].type.name, 'knockout');
        expect(provider.tournaments[1].type.name, 'league');
      },
    );

    test('deleteTournament should remove any tournament type by id', () async {
      when(() => mockStorage.getAll()).thenAnswer((_) async => [t1, t2]);
      when(() => mockStorage.delete(any())).thenAnswer((_) async => {});

      await provider.loadTournaments();
      await provider.deleteTournament(t2.id);

      expect(provider.tournaments.length, 1);
      expect(provider.tournaments.first.id, t1.id);
      verify(() => mockStorage.delete(t2.id)).called(1);
    });

    test(
      'Natural Spanish Sort should work with different tournament implementations',
      () async {
        when(() => mockPrefs.saveSortOption(any())).thenAnswer((_) async => {});
        when(() => mockStorage.getAll()).thenAnswer((_) async => [t2, t1]);

        provider.setSortOption(TournamentSortOptionEnum.nameAsc);
        await provider.loadTournaments();

        expect(provider.tournaments.first.name, 'Árbol');
        expect(provider.tournaments.last.name, 'Zorro');
      },
    );

    test(
      'setSortOption should persist selection regardless of tournament types',
      () {
        when(() => mockPrefs.saveSortOption(any())).thenAnswer((_) async => {});

        provider.setSortOption(TournamentSortOptionEnum.nameDesc);

        expect(provider.sortOption, TournamentSortOptionEnum.nameDesc);
        verify(() => mockPrefs.saveSortOption('nameDesc')).called(1);
      },
    );
  });
}
