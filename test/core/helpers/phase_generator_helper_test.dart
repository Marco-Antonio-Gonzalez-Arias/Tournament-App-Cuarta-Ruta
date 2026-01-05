import 'package:flutter_test/flutter_test.dart';
import 'package:cuarta_ruta_app/core/helpers/phase_generator_helper.dart';
import 'package:cuarta_ruta_app/core/enums/phases_enum.dart';

void main() {
  group('PhaseGeneratorHelper Tests', () {
    test('Should generate sequence from octavos with third place', () {
      final result = PhaseGeneratorHelper.generate(PhasesEnum.octavos, true);

      expect(result, [
        PhasesEnum.octavos,
        PhasesEnum.cuartos,
        PhasesEnum.semifinales,
        PhasesEnum.tercerPuesto,
        PhasesEnum.faseFinal,
      ]);
    });

    test('Should generate sequence from semifinales without third place', () {
      final result = PhaseGeneratorHelper.generate(
        PhasesEnum.semifinales,
        false,
      );

      expect(result, [PhasesEnum.semifinales, PhasesEnum.faseFinal]);
    });

    test(
      'Should always include faseFinal even if startPhase is semifinales',
      () {
        final result = PhaseGeneratorHelper.generate(
          PhasesEnum.semifinales,
          false,
        );
        expect(result.last, PhasesEnum.faseFinal);
      },
    );

    test('Should handle startPhase as cuartos correctly', () {
      final result = PhaseGeneratorHelper.generate(PhasesEnum.cuartos, true);

      expect(result.contains(PhasesEnum.octavos), isFalse);
      expect(result.first, PhasesEnum.cuartos);
      expect(
        result,
        containsAllInOrder([
          PhasesEnum.cuartos,
          PhasesEnum.semifinales,
          PhasesEnum.tercerPuesto,
          PhasesEnum.faseFinal,
        ]),
      );
    });
  });
}
