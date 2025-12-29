import 'dart:convert';
import 'package:uuid/uuid.dart';

enum StartingPhase { 
  octavos, 
  cuartos, 
  semifinales,
}

extension StartingPhaseExtension on StartingPhase {
  String get displayName {
    switch (this) {
      case StartingPhase.octavos:
        return 'Octavos';
      case StartingPhase.cuartos:
        return 'Cuartos';
      case StartingPhase.semifinales:
        return 'Semifinales';
    }
  }
}

class TournamentModel {
  final String id;
  final StartingPhase startPhase;
  final bool hasThirdPlace;
  final bool hasReplica;
  final Map<String, int> roundsConfig; // String en lugar de enum para JSON

  TournamentModel({
    String? id,
    required this.startPhase,
    required this.hasThirdPlace,
    required this.hasReplica,
    required this.roundsConfig,
  }) : id = id ?? const Uuid().v4();

  // Serialización a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'startPhase': startPhase.index,
      'hasThirdPlace': hasThirdPlace,
      'hasReplica': hasReplica,
      'roundsConfig': roundsConfig,
    };
  }

  // Deserialización desde JSON
  factory TournamentModel.fromJson(Map<String, dynamic> json) {
    return TournamentModel(
      id: json['id'],
      startPhase: StartingPhase.values[json['startPhase']],
      hasThirdPlace: json['hasThirdPlace'],
      hasReplica: json['hasReplica'],
      roundsConfig: Map<String, int>.from(json['roundsConfig']),
    );
  }

  String toJsonString() => jsonEncode(toJson());

  factory TournamentModel.fromJsonString(String jsonString) {
    return TournamentModel.fromJson(jsonDecode(jsonString));
  }

  TournamentModel copyWith({
    StartingPhase? startPhase,
    bool? hasThirdPlace,
    bool? hasReplica,
    Map<String, int>? roundsConfig,
  }) {
    return TournamentModel(
      id: id,
      startPhase: startPhase ?? this.startPhase,
      hasThirdPlace: hasThirdPlace ?? this.hasThirdPlace,
      hasReplica: hasReplica ?? this.hasReplica,
      roundsConfig: roundsConfig ?? this.roundsConfig,
    );
  }
}