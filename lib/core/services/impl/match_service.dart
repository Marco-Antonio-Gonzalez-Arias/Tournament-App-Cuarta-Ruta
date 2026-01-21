import 'package:cuarta_ruta_app/core/services/match_service_base.dart';
import 'package:cuarta_ruta_app/models/match_base.dart';
import 'package:cuarta_ruta_app/models/impl/match_model.dart';

class MatchService implements MatchServiceBase {
  @override
  MatchModel setWinner(MatchBase match, String winnerId) {
    if (winnerId != match.participantAId && winnerId != match.participantBId) {
      throw ArgumentError('Winner ID must belong to one of the participants');
    }

    final model = match as MatchModel;

    return model.copyWith(winnerId: winnerId, isCompleted: true);
  }

  @override
  MatchModel resetMatch(MatchBase match) {
    final model = match as MatchModel;

    return model.copyWith(winnerId: null, isCompleted: false);
  }
}
