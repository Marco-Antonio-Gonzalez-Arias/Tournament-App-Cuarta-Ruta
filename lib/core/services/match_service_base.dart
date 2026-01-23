import 'package:cuarta_ruta_app/models/match_base.dart';

abstract class MatchServiceBase {
  MatchBase setWinner(MatchBase match, String winnerId);
  MatchBase resetMatch(MatchBase match);
}
