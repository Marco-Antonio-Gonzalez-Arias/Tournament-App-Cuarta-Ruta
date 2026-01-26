import 'package:flutter_test/flutter_test.dart';
import 'package:cuarta_ruta_app/models/impl/league_tournament_model.dart';

void main() {
  group('LeagueTournamentModel Tests', () {
    test('Constructor should initialize with UUID and current Date', () {
      final model = LeagueTournamentModel(
        name: 'Liga Elite',
        pointsDifference: 2,
        replicaCount: 0,
        participantCount: 12,
        battlesPerParticipant: 2,
        extraPlayer: false,
        roundsPerBattle: 3,
      );

      expect(model.id, isNotEmpty);
      expect(model.name, 'Liga Elite');
      expect(model.createdAt, isA<DateTime>());
      expect(model.participantCount, 12);
    });

    test('fromJson should create a valid model with correct fields', () {
      final json = {
        'id': 'uuid-456',
        'name': 'Liga de Verano',
        'pointsDifference': 3,
        'replicaCount': 1,
        'participantCount': 8,
        'battlesPerParticipant': 1,
        'extraPlayer': true,
        'roundsPerBattle': 2,
        'createdAt': '2024-01-15T10:00:00.000',
      };

      final model = LeagueTournamentModel.fromJson(json);

      expect(model.id, 'uuid-456');
      expect(model.pointsDifference, 3);
      expect(model.extraPlayer, isTrue);
      expect(model.roundsPerBattle, 2);
    });

    test('toJson should return map with correct structure and type', () {
      final model = LeagueTournamentModel(
        name: 'Super Liga',
        pointsDifference: 1,
        replicaCount: 0,
        participantCount: 4,
        battlesPerParticipant: 1,
        extraPlayer: false,
        roundsPerBattle: 1,
      );

      final json = model.toJson();

      expect(json['name'], 'Super Liga');
      expect(json['type'], 'league');
      expect(json['participantCount'], 4);
      expect(json['extraPlayer'], isFalse);
    });

    test('copyWith should maintain immutability of non-specified fields', () {
      final model = LeagueTournamentModel(
        name: 'Base',
        pointsDifference: 2,
        replicaCount: 1,
        participantCount: 10,
        battlesPerParticipant: 1,
        extraPlayer: false,
        roundsPerBattle: 1,
      );

      final updated = model.copyWith(participantCount: 16);

      expect(updated.participantCount, 16);
      expect(updated.name, 'Base');
      expect(updated.id, model.id);
      expect(updated.createdAt, model.createdAt);
    });
  });
}
