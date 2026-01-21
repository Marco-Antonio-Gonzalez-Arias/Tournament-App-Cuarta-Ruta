import 'package:cuarta_ruta_app/core/services/league_participant_service_base.dart';
import 'package:cuarta_ruta_app/models/participant_base.dart';
import 'package:cuarta_ruta_app/models/impl/league_participant_model.dart';

class LeagueParticipantService implements LeagueParticipantServiceBase {
  @override
  LeagueParticipantModel updateStats({
    required ParticipantBase participant,
    required int points,
    required int ptb,
    required bool isWin,
    required bool isReplica,
  }) {
    final model = participant as LeagueParticipantModel;

    return model.copyWith(
      totalPoints: model.totalPoints + points,
      ptb: model.ptb + ptb,
      directWins: isWin && !isReplica ? model.directWins + 1 : model.directWins,
      replicaWins: isWin && isReplica
          ? model.replicaWins + 1
          : model.replicaWins,
      directLosses: !isWin && !isReplica
          ? model.directLosses + 1
          : model.directLosses,
      replicaLosses: !isWin && isReplica
          ? model.replicaLosses + 1
          : model.replicaLosses,
    );
  }
}
