import 'package:flutter_test/flutter_test.dart';
import 'package:cuarta_ruta_app/core/services/impl/league_match_generator_service.dart';

void main() {
  late LeagueMatchGeneratorService service;

  setUp(() {
    service = LeagueMatchGeneratorService();
  });

  group('LeagueMatchGeneratorService Tests', () {
    test(
      'generate should create correct number of matchdays for even participants',
      () {
        final participants = ['p1', 'p2', 'p3', 'p4'];

        final result = service.generate(
          participantIds: participants,
          battlesPerParticipant: 1,
        );

        expect(result.length, 3);
        expect(result[1]?.length, 2);
      },
    );

    test(
      'generate should include extra player matches when battlesPerParticipant is 2',
      () {
        final participants = ['p1', 'p2', 'p3', 'p4'];

        final result = service.generate(
          participantIds: participants,
          battlesPerParticipant: 2,
        );

        bool foundPlaceholder = false;
        for (var matchday in result.values) {
          for (var match in matchday) {
            if (match.participantBId ==
                LeagueMatchGeneratorService.extraPlayerPlaceholder) {
              foundPlaceholder = true;
            }
          }
        }

        expect(foundPlaceholder, isTrue);
      },
    );

    test('generate should ensure every participant plays in a round-robin', () {
      final participants = ['p1', 'p2', 'p3', 'p4'];

      final result = service.generate(
        participantIds: participants,
        battlesPerParticipant: 1,
      );

      final matches = result.values.expand((m) => m).toList();
      final p1Matches = matches.where(
        (m) => m.participantAId == 'p1' || m.participantBId == 'p1',
      );

      expect(p1Matches.length, 3);
    });

    test(
      'generate should group matches correctly based on battlesPerParticipant',
      () {
        final participants = ['p1', 'p2', 'p3', 'p4', 'p5', 'p6'];

        final result = service.generate(
          participantIds: participants,
          battlesPerParticipant: 1,
        );

        expect(result[1]?.length, 3);
      },
    );
  });
}
