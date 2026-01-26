import 'package:flutter_test/flutter_test.dart';
import 'package:cuarta_ruta_app/models/impl/league_participant_model.dart';

void main() {
  group('LeagueParticipantModel Tests', () {
    test('Constructor should initialize with default values', () {
      final participant = LeagueParticipantModel(name: 'League Tester');

      expect(participant.id, isNotEmpty);
      expect(participant.totalPoints, 0);
      expect(participant.ptb, 0);
      expect(participant.directWins, 0);
    });

    test('copyWith should update specified fields', () {
      final participant = LeagueParticipantModel(name: 'Original');

      final updated = participant.copyWith(totalPoints: 3, ptb: 10);

      expect(updated.name, 'Original');
      expect(updated.totalPoints, 3);
      expect(updated.ptb, 10);
      expect(updated.id, participant.id);
    });

    test('fromJson should handle all league statistics', () {
      final json = {
        'id': 'abc',
        'name': 'Pro Player',
        'totalPoints': 9,
        'ptb': 25,
        'directWins': 3,
        'replicaWins': 0,
        'directLosses': 0,
        'replicaLosses': 0,
      };

      final participant = LeagueParticipantModel.fromJson(json);

      expect(participant.totalPoints, 9);
      expect(participant.ptb, 25);
      expect(participant.directWins, 3);
    });

    test('toJson should include all league fields', () {
      final participant = LeagueParticipantModel(
        name: 'Stats Player',
        totalPoints: 5,
        replicaWins: 2,
      );

      final json = participant.toJson();

      expect(json['totalPoints'], 5);
      expect(json['replicaWins'], 2);
      expect(json['name'], 'Stats Player');
    });
  });
}
