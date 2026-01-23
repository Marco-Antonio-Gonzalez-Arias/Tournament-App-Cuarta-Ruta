import 'package:flutter_test/flutter_test.dart';
import 'package:cuarta_ruta_app/core/helpers/phase_generator_helper.dart';
import 'package:cuarta_ruta_app/core/enums/phases_enum.dart';

void main() {
  group('PhaseGeneratorHelper Tests', () {
    test('Should generate sequence from octavos with third place', () {
      final result = PhaseGeneratorHelper.generate(PhasesEnum.roundOf16, true);

      expect(result, [
        PhasesEnum.roundOf16,
        PhasesEnum.quarterFinals,
        PhasesEnum.semifinals,
        PhasesEnum.thirdPlace,
        PhasesEnum.finalPhase,
      ]);
    });

    test('Should generate sequence from semifinales without third place', () {
      final result = PhaseGeneratorHelper.generate(
        PhasesEnum.semifinals,
        false,
      );

      expect(result, [PhasesEnum.semifinals, PhasesEnum.finalPhase]);
    });

    test(
      'Should always include faseFinal even if startPhase is semifinales',
      () {
        final result = PhaseGeneratorHelper.generate(
          PhasesEnum.semifinals,
          false,
        );
        expect(result.last, PhasesEnum.finalPhase);
      },
    );

    test('Should handle startPhase as cuartos correctly', () {
      final result = PhaseGeneratorHelper.generate(PhasesEnum.quarterFinals, true);

      expect(result.contains(PhasesEnum.roundOf16), isFalse);
      expect(result.first, PhasesEnum.quarterFinals);
      expect(
        result,
        containsAllInOrder([
          PhasesEnum.quarterFinals,
          PhasesEnum.semifinals,
          PhasesEnum.thirdPlace,
          PhasesEnum.finalPhase,
        ]),
      );
    });
  });
}
