import 'package:uuid/uuid.dart';
import 'package:cuarta_ruta_app/core/enums/tournament_type_enum.dart';
import 'package:cuarta_ruta_app/models/tournament_session_base.dart';
import 'package:cuarta_ruta_app/models/impl/match_model.dart';
import 'package:cuarta_ruta_app/models/impl/participant_model.dart';

class LeagueSessionModel implements TournamentSessionBase {
  @override
  final String id;
  @override
  final String tournamentId;
  @override
  final TournamentTypeEnum type = TournamentTypeEnum.league;
  @override
  final bool isCompleted;

  final List<ParticipantModel> participants;
  final Map<int, List<MatchModel>> matchesByJourney;

  LeagueSessionModel({
    String? id,
    required this.tournamentId,
    this.isCompleted = false,
    required this.participants,
    required this.matchesByJourney,
  }) : id = id ?? const Uuid().v4();

  LeagueSessionModel copyWith({
    bool? isCompleted,
    List<ParticipantModel>? participants,
    Map<int, List<MatchModel>>? matchesByJourney,
  }) {
    return LeagueSessionModel(
      id: id,
      tournamentId: tournamentId,
      isCompleted: isCompleted ?? this.isCompleted,
      participants: participants ?? this.participants,
      matchesByJourney: matchesByJourney ?? this.matchesByJourney,
    );
  }

  factory LeagueSessionModel.fromJson(Map<String, dynamic> json) {
    final journeysRaw = Map<String, dynamic>.from(json['matchesByJourney']);
    return LeagueSessionModel(
      id: json['id'],
      tournamentId: json['tournamentId'],
      isCompleted: json['isCompleted'] ?? false,
      participants: (json['participants'] as List)
          .map((p) => ParticipantModel.fromJson(p as Map<String, dynamic>))
          .toList(),
      matchesByJourney: journeysRaw.map(
        (k, v) => MapEntry(
          int.parse(k),
          (v as List)
              .map((m) => MatchModel.fromJson(m as Map<String, dynamic>))
              .toList(),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'tournamentId': tournamentId,
    'type': type.name,
    'isCompleted': isCompleted,
    'participants': participants.map((p) => p.toJson()).toList(),
    'matchesByJourney': matchesByJourney.map(
      (k, v) => MapEntry(k.toString(), v.map((m) => m.toJson()).toList()),
    ),
  };
}
