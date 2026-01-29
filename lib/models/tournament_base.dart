import 'package:cuarta_ruta_app/core/enums/tournament_type_enum.dart';

abstract class TournamentBase {
  String get id;
  String get name;
  DateTime get createdAt;
  TournamentTypeEnum get type;
  double get pointsDifference;
  int get replicaCount;
}
