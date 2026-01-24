import 'package:cuarta_ruta_app/core/enums/phases_enum.dart';
import 'package:cuarta_ruta_app/models/impl/knockout_participant_model.dart';
import 'package:cuarta_ruta_app/models/impl/match_model.dart';

abstract class KnockoutAssignmentServiceBase {
  Map<PhasesEnum, List<MatchModel>> assign(
    List<KnockoutParticipantModel> participants,
    Map<PhasesEnum, List<MatchModel>> bracket,
  );

  Map<PhasesEnum, List<MatchModel>> fillAvailableSlots(
    List<KnockoutParticipantModel> participants,
    Map<PhasesEnum, List<MatchModel>> bracket,
  ) {
    if (bracket.isEmpty) return bracket;

    final initialPhaseKey = bracket.keys
        .where((phase) => phase != PhasesEnum.thirdPlace)
        .reduce((a, b) => a.index > b.index ? a : b);

    final List<MatchModel> matches = bracket[initialPhaseKey]!;
    int participantIndex = 0;

    for (int i = 0; i < matches.length; i++) {
      if (participantIndex >= participants.length) break;

      String? currentA = matches[i].participantAId;
      String? currentB = matches[i].participantBId;

      if (currentA == null || currentA.isEmpty) {
        currentA = participants[participantIndex++].id;
      }

      if (participantIndex < participants.length &&
          (currentB == null || currentB.isEmpty)) {
        currentB = participants[participantIndex++].id;
      }

      matches[i] = matches[i].copyWith(
        participantAId: currentA,
        participantBId: currentB,
      );
    }

    return bracket;
  }
}
