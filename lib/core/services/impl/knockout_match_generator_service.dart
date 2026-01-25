import 'package:cuarta_ruta_app/core/enums/phases_enum.dart';
import 'package:cuarta_ruta_app/core/services/knockout_match_generator_service_base.dart';
import 'package:cuarta_ruta_app/models/impl/match_model.dart';

class KnockoutMatchGeneratorService
    implements KnockoutMatchGeneratorServiceBase {
  @override
  Map<PhasesEnum, List<MatchModel>> generateEmptyBracket({
    required PhasesEnum startPhase,
    required bool hasThirdPlace,
  }) {
    final Map<PhasesEnum, List<MatchModel>> bracket = {};

    final List<PhasesEnum> phases = PhaseDisplay.getIterable(
      startPhase,
      hasThirdPlace,
    );

    for (final phase in phases) {
      bracket[phase] = _createEmptyMatchesForPhase(phase);
    }

    return bracket;
  }

  List<MatchModel> _createEmptyMatchesForPhase(PhasesEnum phase) {
    return List.generate(
      phase.matchesCount,
      (_) => MatchModel(participantAId: '', participantBId: ''),
    );
  }
}
