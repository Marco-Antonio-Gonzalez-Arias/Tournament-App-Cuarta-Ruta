import 'package:flutter_test/flutter_test.dart';
import 'package:cuarta_ruta_app/models/impl/league_progress_model.dart';
import 'package:cuarta_ruta_app/models/impl/league_participant_model.dart';
import 'package:cuarta_ruta_app/models/impl/match_model.dart';

void main() {
  group('LeagueProgressModel Tests', () {
    final participants = [LeagueParticipantModel(id: '1', name: 'A')];

    final matches = {
      1: [MatchModel(id: 'm1', participantAId: '1')],
    };

    test('Constructor should initialize journey map correctly', () {
      final progress = LeagueProgressModel(
        tournamentId: 't1',
        participants: participants,
        matchesByJourney: matches,
      );

      expect(progress.type.name, 'league');
      expect(progress.matchesByJourney[1]?.first.id, 'm1');
    });

    test('fromJson should handle integer keys as strings', () {
      final json = {
        'id': 'p1',
        'tournamentId': 't1',
        'participants': [],
        'matchesByJourney': {
          '1': [
            {'id': 'm1', 'isCompleted': true},
          ],
        },
      };

      final progress = LeagueProgressModel.fromJson(json);

      expect(progress.matchesByJourney.containsKey(1), isTrue);
      expect(progress.matchesByJourney[1]?.first.isCompleted, isTrue);
    });

    test('toJson should convert journey keys to strings', () {
      final progress = LeagueProgressModel(
        tournamentId: 't1',
        participants: participants,
        matchesByJourney: matches,
      );

      final json = progress.toJson();

      expect(json['matchesByJourney'].containsKey('1'), isTrue);
    });
  });
}
