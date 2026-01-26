import 'package:flutter_test/flutter_test.dart';
import 'package:cuarta_ruta_app/core/enums/phases_enum.dart';
import 'package:cuarta_ruta_app/core/services/impl/knockout_assignment_random_service.dart';
import 'package:cuarta_ruta_app/models/impl/knockout_participant_model.dart';
import 'package:cuarta_ruta_app/models/impl/match_model.dart';

void main() {
  late KnockoutAssignmentRandomService service;

  final participants = [
    KnockoutParticipantModel(id: 'p1', name: 'Participante 1'),
    KnockoutParticipantModel(id: 'p2', name: 'Participante 2'),
    KnockoutParticipantModel(id: 'p3', name: 'Participante 3'),
    KnockoutParticipantModel(id: 'p4', name: 'Participante 4'),
  ];

  setUp(() {
    service = KnockoutAssignmentRandomService();
  });

  group('KnockoutAssignmentRandomService Tests', () {
    test('assign should fill empty matches with participants', () {
      final bracket = {
        PhasesEnum.semifinals: [MatchModel(id: 'm1'), MatchModel(id: 'm2')],
      };

      final result = service.assign(participants, bracket);

      final allMatches = result[PhasesEnum.semifinals]!;
      expect(allMatches[0].participantAId, isNotNull);
      expect(allMatches[0].participantBId, isNotNull);
      expect(allMatches[1].participantAId, isNotNull);
      expect(allMatches[1].participantBId, isNotNull);
    });

    test('fillAvailableSlots should only fill empty positions', () {
      final bracket = {
        PhasesEnum.semifinals: [
          MatchModel(id: 'm1', participantAId: 'p1'),
          MatchModel(id: 'm2'),
        ],
      };
      final newParticipants = [
        KnockoutParticipantModel(id: 'p2', name: 'P2'),
        KnockoutParticipantModel(id: 'p3', name: 'P3'),
      ];

      final result = service.fillAvailableSlots(newParticipants, bracket);

      final matches = result[PhasesEnum.semifinals]!;
      expect(matches[0].participantAId, 'p1');
      expect(matches[0].participantBId, 'p2');
      expect(matches[1].participantAId, 'p3');
    });

    test('assign should handle more participants than available slots', () {
      final bracket = {
        PhasesEnum.finalPhase: [MatchModel(id: 'm1')],
      };

      final result = service.assign(participants, bracket);

      final match = result[PhasesEnum.finalPhase]!.first;
      expect(match.participantAId, isNotNull);
      expect(match.participantBId, isNotNull);
    });

    test('assign should handle empty bracket', () {
      final Map<PhasesEnum, List<MatchModel>> bracket = {};

      final result = service.assign(participants, bracket);

      expect(result, isEmpty);
    });
  });
}
