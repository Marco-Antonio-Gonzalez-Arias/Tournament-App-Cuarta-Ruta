import 'package:uuid/uuid.dart';

enum Phases { faseFinal, tercerPuesto, semifinales, cuartos, octavos }

extension PhaseDisplay on Phases {
  String get displayName {
    switch (this) {
      case Phases.octavos:
        return 'Octavos';
      case Phases.cuartos:
        return 'Cuartos';
      case Phases.semifinales:
        return 'Semifinales';
      case Phases.tercerPuesto:
        return 'Tercer Puesto';
      case Phases.faseFinal:
        return 'Final';
    }
  }
}

class TournamentModel {
  final String id;
  final Phases startPhase;
  final bool hasThirdPlace;
  final bool hasReplica;
  final Map<Phases, int> roundsConfig;

  TournamentModel({
    required this.startPhase,
    required this.hasThirdPlace,
    required this.hasReplica,
    required this.roundsConfig,
  }) : id = const Uuid().v4();

  TournamentModel._internal({
    required this.id,
    required this.startPhase,
    required this.hasThirdPlace,
    required this.hasReplica,
    required this.roundsConfig,
  });

  TournamentModel copyWith({
    Phases? startPhase,
    bool? hasThirdPlace,
    bool? hasReplica,
    Map<Phases, int>? roundsConfig,
  }) {
    return TournamentModel._internal(
      id: id,
      startPhase: startPhase ?? this.startPhase,
      hasThirdPlace: hasThirdPlace ?? this.hasThirdPlace,
      hasReplica: hasReplica ?? this.hasReplica,
      roundsConfig: roundsConfig ?? this.roundsConfig,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'startPhase': startPhase.name,
      'hasThirdPlace': hasThirdPlace,
      'hasReplica': hasReplica,
      'roundsConfig': roundsConfig.map((k, v) => MapEntry(k.name, v)),
    };
  }

  factory TournamentModel.fromJson(Map<String, dynamic> json) {
    final config = (json['roundsConfig'] as Map).cast<String, int>();
    return TournamentModel._internal(
      id: json['id'],
      startPhase: Phases.values.byName(json['startPhase']),
      hasThirdPlace: json['hasThirdPlace'],
      hasReplica: json['hasReplica'],
      roundsConfig: config.map((k, v) => MapEntry(Phases.values.byName(k), v)),
    );
  }
}