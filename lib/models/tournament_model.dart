import 'package:uuid/uuid.dart';

enum Phases { faseFinal, tercerPuesto, semifinales, cuartos, octavos }

extension PhaseDisplay on Phases {
  String get displayName {
    const names = {
      Phases.octavos: 'Octavos',
      Phases.cuartos: 'Cuartos',
      Phases.semifinales: 'Semifinales',
      Phases.tercerPuesto: 'Tercer Puesto',
      Phases.faseFinal: 'Final',
    };
    return names[this] ?? name;
  }
}

class TournamentModel {
  final String id;
  final String name;
  final Phases startPhase;
  final bool hasThirdPlace;
  final bool hasReplica;
  final Map<Phases, int> roundsConfig;

  TournamentModel({
    required this.name,
    required this.startPhase,
    required this.hasThirdPlace,
    required this.hasReplica,
    required this.roundsConfig,
  }) : id = const Uuid().v4();

  TournamentModel._internal({
    required this.id,
    required this.name,
    required this.startPhase,
    required this.hasThirdPlace,
    required this.hasReplica,
    required this.roundsConfig,
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
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'startPhase': startPhase.name,
    'hasThirdPlace': hasThirdPlace,
    'hasReplica': hasReplica,
    'roundsConfig': roundsConfig.map((k, v) => MapEntry(k.name, v)),
  };
}
