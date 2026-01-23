import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cuarta_ruta_app/core/providers/tournament_list_provider.dart';
import 'package:cuarta_ruta_app/core/services/app_preferences_base.dart';
import 'package:cuarta_ruta_app/core/services/tournament_storage_base.dart';
import 'package:cuarta_ruta_app/core/enums/tournament_sort_option_enum.dart';
import 'package:cuarta_ruta_app/models/impl/tournament_model.dart';
import 'package:cuarta_ruta_app/core/enums/phases_enum.dart';

class MockTournamentStorage extends Mock implements TournamentStorageBase {}

class MockAppPreferences extends Mock implements AppPreferencesBase {}

void main() {
  late MockTournamentStorage mockStorage;
  late MockAppPreferences mockPrefs;
  late TournamentListProvider provider;

  final t1 = TournamentModel(
    name: 'Árbol',
    startPhase: PhasesEnum.quarterFinals,
    hasThirdPlace: false,
    hasReplica: false,
    roundsConfig: {},
  );
  final t2 = TournamentModel(
    name: 'Zorro',
    startPhase: PhasesEnum.quarterFinals,
    hasThirdPlace: false,
    hasReplica: false,
    roundsConfig: {},
  );

  setUp(() {
    mockStorage = MockTournamentStorage();
    mockPrefs = MockAppPreferences();

    when(() => mockPrefs.getSortOption()).thenReturn(null);
    provider = TournamentListProvider(mockStorage, mockPrefs);
  });

  group('TournamentListProvider Tests', () {
    test(
      'loadTournaments should update list and handle loading state',
      () async {
        when(() => mockStorage.getAll()).thenAnswer((_) async => [t1, t2]);

        final future = provider.loadTournaments();
        expect(provider.isLoading, isTrue);

        await future;

        expect(provider.tournaments.length, 2);
        expect(provider.isLoading, isFalse);
        verify(() => mockStorage.getAll()).called(1);
      },
    );

    test(
      'deleteTournament should remove from storage and local list',
      () async {
        when(() => mockStorage.getAll()).thenAnswer((_) async => [t1, t2]);
        when(() => mockStorage.delete(any())).thenAnswer((_) async => {});

        await provider.loadTournaments();
        await provider.deleteTournament(t1.id);

        expect(provider.tournaments.length, 1);
        expect(provider.tournaments.first.id, t2.id);
        verify(() => mockStorage.delete(t1.id)).called(1);
      },
    );

    test('Natural Spanish Sort should handle accents correctly', () async {
      when(() => mockPrefs.saveSortOption(any())).thenAnswer((_) async => {});
      when(() => mockStorage.getAll()).thenAnswer((_) async => [t2, t1]);

      provider.setSortOption(TournamentSortOptionEnum.nameAsc);
      await provider.loadTournaments();

      expect(provider.tournaments.first.name, 'Árbol');
      expect(provider.tournaments.last.name, 'Zorro');
    });

    test('setSortOption should save to preferences', () {
      when(() => mockPrefs.saveSortOption(any())).thenAnswer((_) async => {});

      provider.setSortOption(TournamentSortOptionEnum.nameDesc);

      expect(provider.sortOption, TournamentSortOptionEnum.nameDesc);
      verify(() => mockPrefs.saveSortOption('nameDesc')).called(1);
    });
  });
}
