import 'package:cuarta_ruta_app/core/enums/phases_enum.dart';
import 'package:uuid/uuid.dart';
import 'package:cuarta_ruta_app/core/enums/tournament_type_enum.dart';
import 'package:cuarta_ruta_app/models/tournament_session_base.dart';
import 'package:cuarta_ruta_app/models/impl/match_model.dart';

class KnockoutSessionModel implements TournamentSessionBase {
  @override
  final String id;
  @override
  final String tournamentId;
  @override
  final TournamentTypeEnum type = TournamentTypeEnum.knockout;
  @override
  final bool isCompleted;

  final Set<String> participantIds;
  final Map<PhasesEnum, List<MatchModel>> matchesByPhase;

  KnockoutSessionModel({
    String? id,
    required this.tournamentId,
    this.isCompleted = false,
    required this.participantIds,
    required this.matchesByPhase,
  }) : id = id ?? const Uuid().v4();

  KnockoutSessionModel copyWith({
    bool? isCompleted,
    Set<String>? participantIds,
    Map<PhasesEnum, List<MatchModel>>? matchesByPhase,
  }) {
    return KnockoutSessionModel(
      id: id,
      tournamentId: tournamentId,
      isCompleted: isCompleted ?? this.isCompleted,
      participantIds: participantIds ?? this.participantIds,
      matchesByPhase: matchesByPhase ?? this.matchesByPhase,
    );
  }

  factory KnockoutSessionModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> matchesRaw = json['matchesByPhase'];
    return KnockoutSessionModel(
      id: json['id'],
      tournamentId: json['tournamentId'],
      isCompleted: json['isCompleted'] ?? false,
      participantIds: Set<String>.from(json['participantIds']),
      matchesByPhase: matchesRaw.map(
        (k, v) => MapEntry(
          PhasesEnum.values.byName(k),
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
    'participantIds': participantIds.toList(),
    'matchesByPhase': matchesByPhase.map(
      (k, v) => MapEntry(k.name, v.map((m) => m.toJson()).toList()),
    ),
  };
}
