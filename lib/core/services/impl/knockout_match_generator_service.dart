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

    final List<PhasesEnum> mainPhases = _getMainPathPhases(startPhase);

    for (final phase in mainPhases) {
      bracket[phase] = _createEmptyMatchesForPhase(phase);
    }

    _addThirdPlaceIfRequired(bracket, hasThirdPlace);

    return bracket;
  }

  List<PhasesEnum> _getMainPathPhases(PhasesEnum startPhase) {
    return PhasesEnum.values
        .where(
          (phase) =>
              phase != PhasesEnum.thirdPlace &&
              phase.index <= startPhase.index,
        )
        .toList();
  }

  void _addThirdPlaceIfRequired(
    Map<PhasesEnum, List<MatchModel>> bracket,
    bool hasThirdPlace,
  ) {
    if (hasThirdPlace) {
      bracket[PhasesEnum.thirdPlace] = _createEmptyMatchesForPhase(
        PhasesEnum.thirdPlace,
      );
    }
  }

  List<MatchModel> _createEmptyMatchesForPhase(PhasesEnum phase) {
    return List.generate(
      phase.matchesCount,
      (_) => MatchModel(participantAId: '', participantBId: ''),
    );
  }
}
