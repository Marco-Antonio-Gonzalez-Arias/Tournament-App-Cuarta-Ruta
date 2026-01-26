import 'package:flutter_test/flutter_test.dart';
import 'package:cuarta_ruta_app/core/enums/phases_enum.dart';
import 'package:cuarta_ruta_app/core/services/impl/knockout_match_generator_service.dart';

void main() {
  late KnockoutMatchGeneratorService service;

  setUp(() {
    service = KnockoutMatchGeneratorService();
  });

  group('KnockoutMatchGeneratorService Tests', () {
    test(
      'generateEmptyBracket should create correct structure for Quarter Finals',
      () {
        final result = service.generateEmptyBracket(
          startPhase: PhasesEnum.quarterFinals,
          hasThirdPlace: false,
        );

        expect(result.containsKey(PhasesEnum.quarterFinals), isTrue);
        expect(result.containsKey(PhasesEnum.semifinals), isTrue);
        expect(result.containsKey(PhasesEnum.finalPhase), isTrue);
        expect(result[PhasesEnum.quarterFinals]?.length, 4);
        expect(result[PhasesEnum.semifinals]?.length, 2);
        expect(result[PhasesEnum.finalPhase]?.length, 1);
      },
    );

    test(
      'generateEmptyBracket should include third place match when requested',
      () {
        final result = service.generateEmptyBracket(
          startPhase: PhasesEnum.semifinals,
          hasThirdPlace: true,
        );

        expect(result.containsKey(PhasesEnum.thirdPlace), isTrue);
        expect(result[PhasesEnum.thirdPlace]?.length, 1);
      },
    );

    test('matches should be initialized with empty strings in IDs', () {
      final result = service.generateEmptyBracket(
        startPhase: PhasesEnum.finalPhase,
        hasThirdPlace: false,
      );

      final match = result[PhasesEnum.finalPhase]!.first;
      expect(match.participantAId, '');
      expect(match.participantBId, '');
      expect(match.isCompleted, isFalse);
    });

    test(
      'generateEmptyBracket should create only one match if startPhase is final',
      () {
        final result = service.generateEmptyBracket(
          startPhase: PhasesEnum.finalPhase,
          hasThirdPlace: false,
        );

        expect(result.length, 1);
        expect(result.containsKey(PhasesEnum.finalPhase), isTrue);
      },
    );
  });
}
