import 'package:cuarta_ruta_app/core/enums/phases.dart';

abstract class TournamentBase {
  String get name;
  Phases get startPhase;
  bool get hasThirdPlace;
  bool get hasReplica;
  Map<Phases, int> get roundsConfig;
}
