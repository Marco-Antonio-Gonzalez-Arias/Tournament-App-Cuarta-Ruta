import 'package:flutter_test/flutter_test.dart';
import 'package:cuarta_ruta_app/core/services/impl/match_service.dart';
import 'package:cuarta_ruta_app/models/impl/match_model.dart';

void main() {
  late MatchService service;
  late MatchModel match;

  setUp(() {
    service = MatchService();
    match = MatchModel(id: 'm1', participantAId: 'p1', participantBId: 'p2');
  });

  group('MatchService Tests', () {
    test('setWinner should complete the match and set winnerId', () {
      final result = service.setWinner(match, 'p1');

      expect(result.winnerId, 'p1');
      expect(result.isCompleted, isTrue);
    });

    test(
      'setWinner should throw ArgumentError if winnerId is not a participant',
      () {
        expect(() => service.setWinner(match, 'p3'), throwsArgumentError);
      },
    );

    test('resetMatch should set winnerId to null and isCompleted to false', () {
      final completedMatch = match.copyWith(winnerId: 'p1', isCompleted: true);

      final result = service.resetMatch(completedMatch);

      expect(result.winnerId, isNull);
      expect(result.isCompleted, isFalse);
      expect(result.participantAId, 'p1');
      expect(result.participantBId, 'p2');
    });

    test('resetMatch should not affect participant IDs', () {
      final result = service.resetMatch(match);

      expect(result.participantAId, 'p1');
      expect(result.participantBId, 'p2');
    });
  });
}
