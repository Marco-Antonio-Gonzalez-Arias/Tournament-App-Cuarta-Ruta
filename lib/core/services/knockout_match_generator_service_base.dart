import 'package:cuarta_ruta_app/core/enums/phases_enum.dart';
import 'package:cuarta_ruta_app/models/impl/match_model.dart';

abstract class KnockoutMatchGeneratorServiceBase {
  Map<PhasesEnum, List<MatchModel>> generateEmptyBracket({
    required PhasesEnum startPhase,
    required bool hasThirdPlace,
  });
}
