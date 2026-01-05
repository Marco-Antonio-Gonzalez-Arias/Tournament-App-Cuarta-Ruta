import 'package:cuarta_ruta_app/core/enums/phases_enum.dart';

abstract class TournamentBase {
  String get name;
  PhasesEnum get startPhase;
  bool get hasThirdPlace;
  bool get hasReplica;
  Map<PhasesEnum, int> get roundsConfig;
}
