import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cuarta_ruta_app/core/providers/tournament_provider.dart';
import 'package:cuarta_ruta_app/core/services/tournament_storage_base.dart';
import 'package:cuarta_ruta_app/core/enums/phases_enum.dart';
import 'package:cuarta_ruta_app/core/enums/tournament_type_enum.dart';
import 'package:cuarta_ruta_app/models/impl/knockout_tournament_model.dart';
import 'package:cuarta_ruta_app/models/impl/league_tournament_model.dart';

class MockTournamentStorage extends Mock implements TournamentStorageBase {}

void main() {
  late TournamentProvider provider;
  late MockTournamentStorage mockStorage;

  setUpAll(() {
    registerFallbackValue(
      KnockoutTournamentModel(
        name: '',
        pointsDifference: 2,
        replicaCount: 1,
        startPhase: PhasesEnum.roundOf16,
        hasThirdPlace: false,
        hasWildcard: false,
        roundsConfig: {},
      ),
    );
    registerFallbackValue(
      LeagueTournamentModel(
        name: '',
        pointsDifference: 2,
        replicaCount: 1,
        participantCount: 8,
        battlesPerParticipant: 1,
        extraPlayer: false,
        roundsPerBattle: 1,
      ),
    );
  });

  setUp(() {
    provider = TournamentProvider();
    mockStorage = MockTournamentStorage();
  });

  group('TournamentProvider Tests', () {
    test('Should maintain memory of rounds when switching phases', () {
      provider.updateSingleRound(PhasesEnum.roundOf16, 2);

      provider.updateSettings(phase: PhasesEnum.semifinals);

      expect(provider.roundsConfig[PhasesEnum.roundOf16], 3);
    });

    test(
      'createTournament should filter out irrelevant phases for knockout',
      () async {
        when(() => mockStorage.create(any())).thenAnswer((_) async => {});

        provider.updateSingleRound(PhasesEnum.roundOf16, 2);
        provider.updateSettings(
          type: TournamentTypeEnum.knockout,
          phase: PhasesEnum.semifinals,
          thirdPlace: false,
        );

        await provider.createTournament('Test Filter', mockStorage);

        verify(
          () => mockStorage.create(
            any(
              that: isA<KnockoutTournamentModel>()
                  .having(
                    (t) => t.roundsConfig.containsKey(PhasesEnum.roundOf16),
                    'excludes round of 16',
                    false,
                  )
                  .having(
                    (t) => t.roundsConfig.length,
                    'roundsConfig length',
                    2,
                  ),
            ),
          ),
        ).called(1);
      },
    );

    test('updateSingleRound should clamp values between 1 and 5', () {
      provider.updateSingleRound(PhasesEnum.roundOf16, 10);
      expect(provider.roundsConfig[PhasesEnum.roundOf16], 5);

      provider.updateSingleRound(PhasesEnum.roundOf16, -10);
      expect(provider.roundsConfig[PhasesEnum.roundOf16], 1);
    });
  });
}
