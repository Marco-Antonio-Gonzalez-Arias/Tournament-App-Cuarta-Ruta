import 'package:uuid/uuid.dart';
import 'package:cuarta_ruta_app/core/enums/phases.dart';
import 'package:cuarta_ruta_app/models/tournament_base.dart';

class TournamentModel implements TournamentBase {
  final String id;
  final DateTime createdAt;

  @override
  final String name;
  @override
  final Phases startPhase;
  @override
  final bool hasThirdPlace;
  @override
  final bool hasReplica;
  @override
  final Map<Phases, int> roundsConfig;

  TournamentModel({
    required this.name,
    required this.startPhase,
    required this.hasThirdPlace,
    required this.hasReplica,
    required this.roundsConfig,
  }) : id = const Uuid().v4(),
       createdAt = DateTime.now();

  TournamentModel._internal({
    required this.id,
    required this.name,
    required this.startPhase,
    required this.hasThirdPlace,
    required this.hasReplica,
    required this.roundsConfig,
    required this.createdAt,
  });

  TournamentModel copyWith({
    String? name,
    Phases? startPhase,
    bool? hasThirdPlace,
    bool? hasReplica,
    Map<Phases, int>? roundsConfig,
  }) {
    return TournamentModel._internal(
      id: id,
      createdAt: createdAt,
      name: name ?? this.name,
      startPhase: startPhase ?? this.startPhase,
      hasThirdPlace: hasThirdPlace ?? this.hasThirdPlace,
      hasReplica: hasReplica ?? this.hasReplica,
      roundsConfig: roundsConfig ?? this.roundsConfig,
    );
  }

  factory TournamentModel.fromJson(Map<String, dynamic> json) {
    final config = Map<String, int>.from(json['roundsConfig']);
    return TournamentModel._internal(
      id: json['id'],
      name: json['name'],
      startPhase: Phases.values.byName(json['startPhase']),
      hasThirdPlace: json['hasThirdPlace'],
      hasReplica: json['hasReplica'],
      roundsConfig: config.map((k, v) => MapEntry(Phases.values.byName(k), v)),
      createdAt: DateTime.parse(
        json['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'startPhase': startPhase.name,
    'hasThirdPlace': hasThirdPlace,
    'hasReplica': hasReplica,
    'roundsConfig': roundsConfig.map((k, v) => MapEntry(k.name, v)),
    'createdAt': createdAt.toIso8601String(),
  };
}
