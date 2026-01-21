import 'package:cuarta_ruta_app/models/participant_base.dart';

abstract class LeagueParticipantServiceBase {
  ParticipantBase updateStats({
    required ParticipantBase participant,
    required int points,
    required int ptb,
    required bool isWin,
    required bool isReplica,
  });
}
