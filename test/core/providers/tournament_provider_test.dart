import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cuarta_ruta_app/core/providers/tournament_provider.dart';
import 'package:cuarta_ruta_app/core/services/tournament_storage_base.dart';
import 'package:cuarta_ruta_app/core/enums/phases_enum.dart';
import 'package:cuarta_ruta_app/models/impl/tournament_model.dart';

class MockTournamentStorage extends Mock implements TournamentStorageBase {}

void main() {
  late TournamentProvider provider;
  late MockTournamentStorage mockStorage;

  setUpAll(() {
    registerFallbackValue(
      TournamentModel(
        name: '',
        startPhase: PhasesEnum.roundOf16,
        hasThirdPlace: false,
        hasReplica: false,
        roundsConfig: {},
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

      provider.updateSettings(PhasesEnum.semifinals, false, true);
      expect(provider.roundsConfig[PhasesEnum.roundOf16], 3);

      provider.updateSettings(PhasesEnum.roundOf16, false, true);
      expect(provider.roundsConfig[PhasesEnum.roundOf16], 3);
    });

    test('createTournament should filter out irrelevant phases', () async {
      when(() => mockStorage.create(any())).thenAnswer((_) async => {});

      provider.updateSettings(PhasesEnum.semifinals, false, true);

      await provider.createTournament('Test Filter', mockStorage);

      verify(
        () => mockStorage.create(
          any(
            that: isA<TournamentModel>().having(
              (t) => t.roundsConfig.length,
              'roundsConfig length',
              2,
            ),
          ),
        ),
      ).called(1);
    });

    test('updateSingleRound should clamp values between 1 and 5', () {
      provider.updateSingleRound(PhasesEnum.roundOf16, 10);
      expect(provider.roundsConfig[PhasesEnum.roundOf16], 5);

      provider.updateSingleRound(PhasesEnum.roundOf16, -10);
      expect(provider.roundsConfig[PhasesEnum.roundOf16], 1);
    });
  });
}
