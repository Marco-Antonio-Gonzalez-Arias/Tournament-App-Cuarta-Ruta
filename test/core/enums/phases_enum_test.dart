import 'package:flutter_test/flutter_test.dart';
import 'package:cuarta_ruta_app/core/enums/phases_enum.dart';

void main() {
  group('PhasesEnum Extension Tests', () {
    test('displayName should return correct Spanish names', () {
      const roundOf16 = PhasesEnum.roundOf16;
      const thirdPlace = PhasesEnum.thirdPlace;

      final nameOctavos = roundOf16.displayName;
      final nameThird = thirdPlace.displayName;

      expect(nameOctavos, 'Octavos');
      expect(nameThird, 'Tercer Puesto');
    });

    test(
      'getIterable should return correct phases sequence from Round of 16 without third place',
      () {
        const startPhase = PhasesEnum.roundOf16;
        const hasThirdPlace = false;

        final result = PhaseDisplay.getIterable(startPhase, hasThirdPlace);

        expect(result, [
          PhasesEnum.roundOf16,
          PhasesEnum.quarterFinals,
          PhasesEnum.semifinals,
          PhasesEnum.finalPhase,
        ]);
      },
    );

    test(
      'getIterable should include third place when hasThirdPlace is true',
      () {
        const startPhase = PhasesEnum.semifinals;
        const hasThirdPlace = true;

        final result = PhaseDisplay.getIterable(startPhase, hasThirdPlace);

        expect(result, [
          PhasesEnum.semifinals,
          PhasesEnum.thirdPlace,
          PhasesEnum.finalPhase,
        ]);
      },
    );

    test('matchesCount should return correct values for each phase', () {
      const roundOf16 = PhasesEnum.roundOf16;
      const finalPhase = PhasesEnum.finalPhase;

      final matches16 = roundOf16.matchesCount;
      final matchesFinal = finalPhase.matchesCount;

      expect(matches16, 8);
      expect(matchesFinal, 1);
    });
  });
}
