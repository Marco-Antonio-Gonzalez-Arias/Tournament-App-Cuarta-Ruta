import 'package:flutter_test/flutter_test.dart';
import 'package:cuarta_ruta_app/models/impl/knockout_progress_model.dart';
import 'package:cuarta_ruta_app/models/impl/knockout_participant_model.dart';
import 'package:cuarta_ruta_app/models/impl/match_model.dart';
import 'package:cuarta_ruta_app/core/enums/phases_enum.dart';

void main() {
  group('KnockoutProgressModel Tests', () {
    final participants = [
      KnockoutParticipantModel(id: '1', name: 'A'),
      KnockoutParticipantModel(id: '2', name: 'B'),
    ];

    final matches = {
      PhasesEnum.finalPhase: [
        MatchModel(id: 'm1', participantAId: '1', participantBId: '2'),
      ],
    };

    test('Constructor should initialize correctly', () {
      final progress = KnockoutProgressModel(
        tournamentId: 't1',
        participants: participants,
        matchesByPhase: matches,
      );

      expect(progress.id, isNotEmpty);
      expect(progress.type.name, 'knockout');
      expect(progress.matchesByPhase[PhasesEnum.finalPhase]?.length, 1);
    });

    test('fromJson should reconstruct deep maps correctly', () {
      final json = {
        'id': 'p1',
        'tournamentId': 't1',
        'isCompleted': false,
        'participants': [
          {'id': '1', 'name': 'A'},
        ],
        'matchesByPhase': {
          'finalPhase': [
            {'id': 'm1', 'participantAId': '1', 'isCompleted': false},
          ],
        },
      };

      final progress = KnockoutProgressModel.fromJson(json);

      expect(progress.participants.first.name, 'A');
      expect(
        progress.matchesByPhase.containsKey(PhasesEnum.finalPhase),
        isTrue,
      );
    });

    test('toJson should preserve phase enum names as keys', () {
      final progress = KnockoutProgressModel(
        tournamentId: 't1',
        participants: participants,
        matchesByPhase: matches,
      );

      final json = progress.toJson();

      expect(json['matchesByPhase'].containsKey('finalPhase'), isTrue);
      expect(json['type'], 'knockout');
    });
  });
}
