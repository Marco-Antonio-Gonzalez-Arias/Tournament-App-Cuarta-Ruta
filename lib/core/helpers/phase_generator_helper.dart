import 'package:cuarta_ruta_app/models/tournament_model.dart';

class PhaseGeneratorHelper {
  static List<Phases> generate(Phases startPhase, bool hasThirdPlace) {
    final phases = Phases.values.where((p) {
      if (p == Phases.tercerPuesto || p == Phases.faseFinal) return false;
      return p.index <= startPhase.index;
    }).toList();

    final sortedPhases = phases.reversed.toList();

    if (hasThirdPlace) sortedPhases.add(Phases.tercerPuesto);
    sortedPhases.add(Phases.faseFinal);

    return sortedPhases;
  }
}
