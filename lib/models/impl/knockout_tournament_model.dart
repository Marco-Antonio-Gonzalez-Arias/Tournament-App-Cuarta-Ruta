import 'package:uuid/uuid.dart';
import 'package:cuarta_ruta_app/core/enums/phases_enum.dart';
import 'package:cuarta_ruta_app/core/enums/tournament_type_enum.dart';
import 'package:cuarta_ruta_app/models/tournament_base.dart';

class KnockoutTournamentModel implements TournamentBase {
  @override
  final String id;
  @override
  final DateTime createdAt;
  @override
  final String name;
  @override
  final TournamentTypeEnum type = TournamentTypeEnum.knockout;
  @override
  final double pointsDifference;
  @override
  final int replicaCount;

  final PhasesEnum startPhase;
  final bool hasThirdPlace;
  final Map<PhasesEnum, int> roundsConfig;
  final bool hasWildcard;

  KnockoutTournamentModel({
    String? id,
    DateTime? createdAt,
    required this.name,
    required this.pointsDifference,
    required this.replicaCount,
    required this.startPhase,
    required this.hasThirdPlace,
    required this.roundsConfig,
    required this.hasWildcard,
  }) : id = id ?? const Uuid().v4(),
       createdAt = createdAt ?? DateTime.now();

  KnockoutTournamentModel copyWith({
    String? name,
    double? pointsDifference,
    int? replicaCount,
    PhasesEnum? startPhase,
    bool? hasThirdPlace,
    Map<PhasesEnum, int>? roundsConfig,
    bool? hasWildcard,
  }) {
    return KnockoutTournamentModel(
      id: id,
      createdAt: createdAt,
      name: name ?? this.name,
      pointsDifference: pointsDifference ?? this.pointsDifference,
      replicaCount: replicaCount ?? this.replicaCount,
      startPhase: startPhase ?? this.startPhase,
      hasThirdPlace: hasThirdPlace ?? this.hasThirdPlace,
      roundsConfig: roundsConfig ?? this.roundsConfig,
      hasWildcard: hasWildcard ?? this.hasWildcard,
    );
  }

  factory KnockoutTournamentModel.fromJson(Map<String, dynamic> json) {
    final config = Map<String, int>.from(json['roundsConfig']);
    return KnockoutTournamentModel(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      name: json['name'],
      pointsDifference: (json['pointsDifference'] as num).toDouble(),
      replicaCount: json['replicaCount'],
      startPhase: PhasesEnum.values.byName(json['startPhase']),
      hasThirdPlace: json['hasThirdPlace'],
      roundsConfig: config.map(
        (k, v) => MapEntry(PhasesEnum.values.byName(k), v),
      ),
      hasWildcard: json['hasWildcard'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'createdAt': createdAt.toIso8601String(),
    'name': name,
    'type': type.name,
    'pointsDifference': pointsDifference,
    'replicaCount': replicaCount,
    'startPhase': startPhase.name,
    'hasThirdPlace': hasThirdPlace,
    'roundsConfig': roundsConfig.map((k, v) => MapEntry(k.name, v)),
    'hasWildcard': hasWildcard,
  };
}
