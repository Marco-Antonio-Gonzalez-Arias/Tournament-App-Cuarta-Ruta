import 'package:cuarta_ruta_app/core/enums/phases_enum.dart';
import 'package:uuid/uuid.dart';
import 'package:cuarta_ruta_app/core/enums/tournament_type_enum.dart';
import 'package:cuarta_ruta_app/models/tournament_progress_base.dart';
import 'package:cuarta_ruta_app/models/impl/match_model.dart';
import 'package:cuarta_ruta_app/models/impl/knockout_participant_model.dart';

class KnockoutProgressModel implements TournamentProgressBase {
  @override
  final String id;
  @override
  final String tournamentId;
  @override
  final TournamentTypeEnum type = TournamentTypeEnum.knockout;
  @override
  final bool isCompleted;

  final List<KnockoutParticipantModel> participants;
  final Map<PhasesEnum, List<MatchModel>> matchesByPhase;

  KnockoutProgressModel({
    String? id,
    required this.tournamentId,
    this.isCompleted = false,
    required this.participants,
    required this.matchesByPhase,
  }) : id = id ?? const Uuid().v4();

  KnockoutProgressModel copyWith({
    bool? isCompleted,
    List<KnockoutParticipantModel>? participants,
    Map<PhasesEnum, List<MatchModel>>? matchesByPhase,
  }) {
    return KnockoutProgressModel(
      id: id,
      tournamentId: tournamentId,
      isCompleted: isCompleted ?? this.isCompleted,
      participants: participants ?? this.participants,
      matchesByPhase: matchesByPhase ?? this.matchesByPhase,
    );
  }

  factory KnockoutProgressModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> matchesRaw = json['matchesByPhase'];
    return KnockoutProgressModel(
      id: json['id'],
      tournamentId: json['tournamentId'],
      isCompleted: json['isCompleted'] ?? false,
      participants: (json['participants'] as List)
          .map(
            (p) => KnockoutParticipantModel.fromJson(p as Map<String, dynamic>),
          )
          .toList(),
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
    'participants': participants.map((p) => p.toJson()).toList(),
    'matchesByPhase': matchesByPhase.map(
      (k, v) => MapEntry(k.name, v.map((m) => m.toJson()).toList()),
    ),
  };
}
