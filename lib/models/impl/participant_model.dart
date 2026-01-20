import 'package:uuid/uuid.dart';
import 'package:cuarta_ruta_app/models/participant_base.dart';

class ParticipantModel implements ParticipantBase {
  @override
  final String id;
  @override
  final String name;

  final int totalPoints;
  final int ptb;
  final int directWins;
  final int replicaWins;
  final int directLosses;
  final int replicaLosses;

  ParticipantModel({
    String? id,
    required this.name,
    this.totalPoints = 0,
    this.ptb = 0,
    this.directWins = 0,
    this.replicaWins = 0,
    this.directLosses = 0,
    this.replicaLosses = 0,
  }) : id = id ?? const Uuid().v4();

  ParticipantModel copyWith({
    String? name,
    int? totalPoints,
    int? ptb,
    int? directWins,
    int? replicaWins,
    int? directLosses,
    int? replicaLosses,
  }) {
    return ParticipantModel(
      id: id,
      name: name ?? this.name,
      totalPoints: totalPoints ?? this.totalPoints,
      ptb: ptb ?? this.ptb,
      directWins: directWins ?? this.directWins,
      replicaWins: replicaWins ?? this.replicaWins,
      directLosses: directLosses ?? this.directLosses,
      replicaLosses: replicaLosses ?? this.replicaLosses,
    );
  }

  factory ParticipantModel.fromJson(Map<String, dynamic> json) =>
      ParticipantModel(
        id: json['id'],
        name: json['name'],
        totalPoints: json['totalPoints'] ?? 0,
        ptb: json['ptb'] ?? 0,
        directWins: json['directWins'] ?? 0,
        replicaWins: json['replicaWins'] ?? 0,
        directLosses: json['directLosses'] ?? 0,
        replicaLosses: json['replicaLosses'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'totalPoints': totalPoints,
    'ptb': ptb,
    'directWins': directWins,
    'replicaWins': replicaWins,
    'directLosses': directLosses,
    'replicaLosses': replicaLosses,
  };
}
