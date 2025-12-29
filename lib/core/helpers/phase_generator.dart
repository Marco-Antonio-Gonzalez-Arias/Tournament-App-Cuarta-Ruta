import 'package:cuarta_ruta_app/models/tournament_model.dart';

class PhaseGenerator {
  static List<String> generatePhases(
    StartingPhase startPhase,
    bool hasThirdPlace,
  ) {
    final phases = <String>[];

    switch (startPhase) {
      case StartingPhase.octavos:
        phases.addAll(['OCTAVOS', 'CUARTOS', 'SEMIS']);
        break;
      case StartingPhase.cuartos:
        phases.addAll(['CUARTOS', 'SEMIS']);
        break;
      case StartingPhase.semifinales:
        phases.add('SEMIS');
        break;
    }

    if (hasThirdPlace) {
      phases.add('3ER/4TO');
    }

    phases.add('FINAL');

    return phases;
  }
}