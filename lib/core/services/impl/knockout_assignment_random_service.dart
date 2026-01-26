import 'dart:math';
import 'package:cuarta_ruta_app/core/enums/phases_enum.dart';
import 'package:cuarta_ruta_app/models/impl/knockout_participant_model.dart';
import 'package:cuarta_ruta_app/models/impl/match_model.dart';
import 'package:cuarta_ruta_app/core/services/knockout_assignment_service_base.dart';

class KnockoutAssignmentRandomService
    extends KnockoutAssignmentServiceBase {
  @override
  Map<PhasesEnum, List<MatchModel>> assign(
    List<KnockoutParticipantModel> participants,
    Map<PhasesEnum, List<MatchModel>> bracket,
  ) {
    final shuffled = List<KnockoutParticipantModel>.from(participants)
      ..shuffle(Random());
    return fillAvailableSlots(shuffled, bracket);
  }
}
