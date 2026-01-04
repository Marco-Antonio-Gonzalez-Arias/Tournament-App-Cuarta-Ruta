import 'package:cuarta_ruta_app/core/enums/phases_enum.dart';

class PhaseGeneratorHelper {
  static List<PhasesEnum> generate(PhasesEnum startPhase, bool hasThirdPlace) {
    final phases = PhasesEnum.values.where((p) {
      if (p == PhasesEnum.tercerPuesto || p == PhasesEnum.faseFinal) return false;
      return p.index <= startPhase.index;
    }).toList();

    final sortedPhases = phases.reversed.toList();

    if (hasThirdPlace) sortedPhases.add(PhasesEnum.tercerPuesto);
    sortedPhases.add(PhasesEnum.faseFinal);

    return sortedPhases;
  }
}
