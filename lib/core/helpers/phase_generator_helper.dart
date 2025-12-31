import 'package:cuarta_ruta_app/models/tournament_model.dart';

class PhaseGeneratorHelper {
  static List<Phases> generate(Phases startPhase, bool hasThirdPlace) {
    final phases = <Phases>[];

    if (startPhase.index >= Phases.octavos.index) phases.add(Phases.octavos);
    if (startPhase.index >= Phases.cuartos.index) phases.add(Phases.cuartos);
    phases.add(Phases.semifinales);
    if (hasThirdPlace) phases.add(Phases.tercerPuesto);
    phases.add(Phases.faseFinal);

    return phases;
  }
}
