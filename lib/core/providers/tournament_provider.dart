import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/enums/phases_enum.dart';
import 'package:cuarta_ruta_app/core/enums/tournament_type_enum.dart';
import 'package:cuarta_ruta_app/core/services/tournament_storage_base.dart';
import 'package:cuarta_ruta_app/models/impl/knockout_tournament_model.dart';
import 'package:cuarta_ruta_app/models/impl/league_tournament_model.dart';

class TournamentProvider extends ChangeNotifier {
  TournamentTypeEnum _type = TournamentTypeEnum.knockout;
  PhasesEnum _selectedPhase = PhasesEnum.roundOf16;
  bool _hasThirdPlace = false;
  bool _hasWildcard = false;
  int _replicaCount = 1;
  int _pointsDifference = 2;

  // Propiedades de Liga
  int _participantCount = 8;
  int _battlesPerParticipant = 1;
  bool _extraPlayer = false;
  int _roundsPerBattle = 1;

  final Map<PhasesEnum, int> _roundsConfig = {};

  TournamentProvider() {
    _initializeDefaultRounds();
  }

  // Getters
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
    _roundsConfig.clear();
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
    _replicaCount = replicas ?? _replicaCount;
    _pointsDifference = pointsDiff ?? _pointsDifference;
    _participantCount = participants ?? _participantCount;
    _battlesPerParticipant = battles ?? _battlesPerParticipant;
    _extraPlayer = extra ?? _extraPlayer;
    _roundsPerBattle = rounds ?? _roundsPerBattle;

    _initializeDefaultRounds();
    notifyListeners();
  }

  void updateSingleRound(PhasesEnum phase, int delta) {
    final current = _roundsConfig[phase] ?? 1;
    _roundsConfig[phase] = (current + delta).clamp(1, 5);
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
