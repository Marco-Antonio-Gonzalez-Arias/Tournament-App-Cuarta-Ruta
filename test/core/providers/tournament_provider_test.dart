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
        startPhase: PhasesEnum.octavos,
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
      provider.updateSingleRound(PhasesEnum.octavos, 2);

      provider.updateSettings(PhasesEnum.semifinales, false, true);
      expect(provider.roundsConfig[PhasesEnum.octavos], 3);

      provider.updateSettings(PhasesEnum.octavos, false, true);
      expect(provider.roundsConfig[PhasesEnum.octavos], 3);
    });

    test('createTournament should filter out irrelevant phases', () async {
      when(() => mockStorage.create(any())).thenAnswer((_) async => {});

      provider.updateSettings(PhasesEnum.semifinales, false, true);

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
      provider.updateSingleRound(PhasesEnum.octavos, 10);
      expect(provider.roundsConfig[PhasesEnum.octavos], 5);

      provider.updateSingleRound(PhasesEnum.octavos, -10);
      expect(provider.roundsConfig[PhasesEnum.octavos], 1);
    });
  });
}
