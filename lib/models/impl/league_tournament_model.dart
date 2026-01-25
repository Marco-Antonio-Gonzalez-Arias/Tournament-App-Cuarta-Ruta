import 'package:uuid/uuid.dart';
import 'package:cuarta_ruta_app/core/enums/tournament_type_enum.dart';
import 'package:cuarta_ruta_app/models/tournament_base.dart';

class LeagueTournamentModel implements TournamentBase {
  @override
  final String id;
  @override
  final DateTime createdAt;
  @override
  final String name;
  @override
  final TournamentTypeEnum type = TournamentTypeEnum.league;
  @override
  final int pointsDifference;
  @override
  final int replicaCount;

  final int participantCount;
  final int battlesPerParticipant;
  final bool extraPlayer;
  final int roundsPerBattle;

  LeagueTournamentModel({
    String? id,
    DateTime? createdAt,
    required this.name,
    required this.pointsDifference,
    required this.replicaCount,
    required this.participantCount,
    required this.battlesPerParticipant,
    required this.extraPlayer,
    required this.roundsPerBattle,
  }) : id = id ?? const Uuid().v4(),
       createdAt = createdAt ?? DateTime.now();

  LeagueTournamentModel copyWith({
    String? name,
    int? pointsDifference,
    int? replicaCount,
    int? participantCount,
    int? battlesPerParticipant,
    bool? extraPlayer,
    int? roundsPerBattle,
  }) {
    return LeagueTournamentModel(
      id: id,
      createdAt: createdAt,
      name: name ?? this.name,
      pointsDifference: pointsDifference ?? this.pointsDifference,
      replicaCount: replicaCount ?? this.replicaCount,
      participantCount: participantCount ?? this.participantCount,
      battlesPerParticipant:
          battlesPerParticipant ?? this.battlesPerParticipant,
      extraPlayer: extraPlayer ?? this.extraPlayer,
      roundsPerBattle: roundsPerBattle ?? this.roundsPerBattle,
    );
  }

  factory LeagueTournamentModel.fromJson(Map<String, dynamic> json) {
    return LeagueTournamentModel(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      name: json['name'],
      pointsDifference: json['pointsDifference'],
      replicaCount: json['replicaCount'],
      participantCount: json['participantCount'],
      battlesPerParticipant: json['battlesPerParticipant'],
      extraPlayer: json['extraPlayer'],
      roundsPerBattle: json['roundsPerBattle'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'createdAt': createdAt.toIso8601String(),
    'name': name,
    'type': type.name,
    'pointsDifference': pointsDifference,
    'replicaCount': replicaCount,
    'participantCount': participantCount,
    'battlesPerParticipant': battlesPerParticipant,
    'extraPlayer': extraPlayer,
    'roundsPerBattle': roundsPerBattle,
  };
}
