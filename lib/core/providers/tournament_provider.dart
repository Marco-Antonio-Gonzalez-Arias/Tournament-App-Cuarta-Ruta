import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/enums/phases_enum.dart';
import 'package:cuarta_ruta_app/core/helpers/phase_generator_helper.dart';
import 'package:cuarta_ruta_app/core/services/tournament_storage_base.dart';
import 'package:cuarta_ruta_app/models/impl/tournament_model.dart';

class TournamentProvider extends ChangeNotifier {
  PhasesEnum _selectedPhase = PhasesEnum.octavos;
  bool _hasThirdPlace = false;
  bool _hasReplica = true;

  final Map<PhasesEnum, int> _roundsConfig = {};

  TournamentProvider() {
    _initializeDefaultRounds();
  }

  PhasesEnum get selectedPhase => _selectedPhase;
  bool get hasThirdPlace => _hasThirdPlace;
  bool get hasReplica => _hasReplica;
  Map<PhasesEnum, int> get roundsConfig => _roundsConfig;

  void _initializeDefaultRounds() {
    final phases = PhaseGeneratorHelper.generate(
      _selectedPhase,
      _hasThirdPlace,
    );

    for (final phase in phases) {
      _roundsConfig.putIfAbsent(phase, () => 1);
    }
  }

  void updateSettings(PhasesEnum phase, bool third, bool replica) {
    _selectedPhase = phase;
    _hasThirdPlace = third;
    _hasReplica = replica;

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
    final validPhases = PhaseGeneratorHelper.generate(
      _selectedPhase,
      _hasThirdPlace,
    );

    final filteredRoundsConfig = {
      for (final phase in validPhases) phase: _roundsConfig[phase] ?? 1,
    };
    final tournament = TournamentModel(
      name: name,
      startPhase: _selectedPhase,
      hasThirdPlace: _hasThirdPlace,
      hasReplica: _hasReplica,
      roundsConfig: filteredRoundsConfig,
    );

    await storage.create(tournament);
  }
}
