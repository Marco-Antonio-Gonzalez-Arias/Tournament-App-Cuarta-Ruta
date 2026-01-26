import 'package:flutter_test/flutter_test.dart';
import 'package:cuarta_ruta_app/models/impl/match_model.dart';

void main() {
  group('MatchModel Tests', () {
    test(
      'Constructor should initialize with UUID and default completion status',
      () {
        final match = MatchModel(participantAId: 'p1', participantBId: 'p2');

        expect(match.id, isNotEmpty);
        expect(match.participantAId, 'p1');
        expect(match.participantBId, 'p2');
        expect(match.isCompleted, isFalse);
        expect(match.winnerId, isNull);
      },
    );

    test('copyWith should update specified fields and maintain id', () {
      final match = MatchModel(participantAId: 'p1', participantBId: 'p2');

      final updated = match.copyWith(winnerId: 'p1', isCompleted: true);

      expect(updated.id, match.id);
      expect(updated.winnerId, 'p1');
      expect(updated.isCompleted, isTrue);
      expect(updated.participantAId, 'p1');
    });

    test('fromJson should create valid model from map', () {
      final json = {
        'id': 'match-123',
        'participantAId': 'p1',
        'participantBId': 'p2',
        'winnerId': 'p1',
        'isCompleted': true,
      };

      final match = MatchModel.fromJson(json);

      expect(match.id, 'match-123');
      expect(match.participantAId, 'p1');
      expect(match.isCompleted, isTrue);
    });

    test('toJson should return correct map structure', () {
      final match = MatchModel(
        id: 'match-123',
        participantAId: 'p1',
        isCompleted: false,
      );

      final json = match.toJson();

      expect(json['id'], 'match-123');
      expect(json['participantAId'], 'p1');
      expect(json['participantBId'], isNull);
      expect(json['isCompleted'], isFalse);
    });
  });
}
