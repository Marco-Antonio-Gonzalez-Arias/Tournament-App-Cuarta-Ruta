import 'package:cuarta_ruta_app/models/impl/match_model.dart';

abstract class LeagueMatchGeneratorServiceBase {
  Map<int, List<MatchModel>> generate({
    required List<String> participantIds,
    required int battlesPerParticipant,
  });
}
