import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/enums/phases_enum.dart';
import 'package:cuarta_ruta_app/core/enums/tournament_type_enum.dart';
import 'package:cuarta_ruta_app/core/services/tournament_storage_base.dart';
import 'package:cuarta_ruta_app/models/impl/knockout_tournament_model.dart';
import 'package:cuarta_ruta_app/models/impl/league_tournament_model.dart';

class TournamentProvider extends ChangeNotifier {
  // Reglas de Negocio Centralizadas
  static const int minPointsDiff = 1;
  static const int maxPointsDiff = 3;
  static const int minReplicas = 1;
  static const int maxReplicas = 2;
  static const int minParticipants = 8;
  static const int maxParticipants = 12;
  static const int stepParticipants = 2;
  static const int minBattles = 1;
  static const int maxBattles = 2;
  static const int minRounds = 1;
  static const int maxRounds = 10;
  static const int minPhaseRounds = 1;
  static const int maxPhaseRounds = 5;

  TournamentTypeEnum _type = TournamentTypeEnum.knockout;
  PhasesEnum _selectedPhase = PhasesEnum.roundOf16;
  bool _hasThirdPlace = false;
  bool _hasWildcard = false;
  int _replicaCount = 1;
  int _pointsDifference = 2;

  int _participantCount = 8;
  int _battlesPerParticipant = 1;
  bool _extraPlayer = false;
  int _roundsPerBattle = 1;

  final Map<PhasesEnum, int> _roundsConfig = {};

  TournamentProvider() {
    _initializeDefaultRounds();
  }

  TournamentTypeEnum get type => _type;
  PhasesEnum get selectedPhase => _selectedPhase;
  bool get hasThirdPlace => _hasThirdPlace;
  bool get hasWildcard => _hasWildcard;
  int get replicaCount => _replicaCount;
  int get pointsDifference => _pointsDifference;
  int get participantCount => _participantCount;
  int get battlesPerParticipant => _battlesPerParticipant;
  bool get extraPlayer => _extraPlayer;
  int get roundsPerBattle => _roundsPerBattle;
  Map<PhasesEnum, int> get roundsConfig => _roundsConfig;

  void _initializeDefaultRounds() {
    final phases = PhaseDisplay.getIterable(_selectedPhase, _hasThirdPlace);
    for (final phase in phases) {
      _roundsConfig.putIfAbsent(phase, () => 1);
    }
  }

  void updateSettings({
    TournamentTypeEnum? type,
    PhasesEnum? phase,
    bool? thirdPlace,
    bool? wildcard,
    int? replicas,
    int? pointsDiff,
    int? participants,
    int? battles,
    bool? extra,
    int? rounds,
  }) {
    _type = type ?? _type;
    _selectedPhase = phase ?? _selectedPhase;
    _hasThirdPlace = thirdPlace ?? _hasThirdPlace;
    _hasWildcard = wildcard ?? _hasWildcard;
    _extraPlayer = extra ?? _extraPlayer;

    _replicaCount = (replicas ?? _replicaCount).clamp(minReplicas, maxReplicas);
    _pointsDifference = (pointsDiff ?? _pointsDifference).clamp(
      minPointsDiff,
      maxPointsDiff,
    );
    _participantCount = (participants ?? _participantCount).clamp(
      minParticipants,
      maxParticipants,
    );
    _battlesPerParticipant = (battles ?? _battlesPerParticipant).clamp(
      minBattles,
      maxBattles,
    );
    _roundsPerBattle = (rounds ?? _roundsPerBattle).clamp(minRounds, maxRounds);

    _initializeDefaultRounds();
    notifyListeners();
  }

  void updateSingleRound(PhasesEnum phase, int delta) {
    final current = _roundsConfig[phase] ?? 1;
    _roundsConfig[phase] = (current + delta).clamp(
      minPhaseRounds,
      maxPhaseRounds,
    );
    notifyListeners();
  }

  Future<void> createTournament(
    String name,
    TournamentStorageBase storage,
  ) async {
    if (_type == TournamentTypeEnum.knockout) {
      final validPhases = PhaseDisplay.getIterable(
        _selectedPhase,
        _hasThirdPlace,
      );
      final filteredRoundsConfig = {
        for (final phase in validPhases) phase: _roundsConfig[phase] ?? 1,
      };

      await storage.create(
        KnockoutTournamentModel(
          name: name,
          pointsDifference: _pointsDifference,
          replicaCount: _replicaCount,
          startPhase: _selectedPhase,
          hasThirdPlace: _hasThirdPlace,
          hasWildcard: _hasWildcard,
          roundsConfig: filteredRoundsConfig,
        ),
      );
    } else {
      await storage.create(
        LeagueTournamentModel(
          name: name,
          pointsDifference: _pointsDifference,
          replicaCount: _replicaCount,
          participantCount: _participantCount,
          battlesPerParticipant: _battlesPerParticipant,
          extraPlayer: _extraPlayer,
          roundsPerBattle: _roundsPerBattle,
        ),
      );
    }
  }
}
