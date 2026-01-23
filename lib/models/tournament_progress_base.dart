import 'package:cuarta_ruta_app/core/enums/tournament_type_enum.dart';

abstract class TournamentProgressBase {
  String get id;
  String get tournamentId;
  TournamentTypeEnum get type;
  bool get isCompleted;
}