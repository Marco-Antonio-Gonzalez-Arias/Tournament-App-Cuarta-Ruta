import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/enums/phases.dart';
import 'package:cuarta_ruta_app/core/helpers/phase_generator_helper.dart';
import 'package:cuarta_ruta_app/core/services/tournament_storage_base.dart';
import 'package:cuarta_ruta_app/models/tournament_model.dart';

class TournamentProvider extends ChangeNotifier {
  Phases _selectedPhase = Phases.octavos;
  bool _hasThirdPlace = false;
  bool _hasReplica = true;
  final Map<Phases, int> _roundsConfig = {};

  TournamentProvider() {
    _initializeDefaultRounds();
  }

  Phases get selectedPhase => _selectedPhase;
  bool get hasThirdPlace => _hasThirdPlace;
  bool get hasReplica => _hasReplica;
  Map<Phases, int> get roundsConfig => _roundsConfig;

  void _initializeDefaultRounds() {
    _roundsConfig.clear();
    final phases = PhaseGeneratorHelper.generate(
      _selectedPhase,
      _hasThirdPlace,
    );
    for (var phase in phases) {
      _roundsConfig[phase] = 1;
    }
  }

  void updateSettings(Phases phase, bool third, bool replica) {
    _selectedPhase = phase;
    _hasThirdPlace = third;
    _hasReplica = replica;
    _initializeDefaultRounds();
    notifyListeners();
  }

  void updateSingleRound(Phases phase, int delta) {
    final currentCount = _roundsConfig[phase] ?? 1;
    _roundsConfig[phase] = (currentCount + delta).clamp(1, 5);
    notifyListeners();
  }

  Future<void> createTournament(
    String name,
    TournamentStorageBase storage,
  ) async {
    final tournament = TournamentModel(
      name: name,
      startPhase: selectedPhase,
      hasThirdPlace: hasThirdPlace,
      hasReplica: hasReplica,
      roundsConfig: Map.from(_roundsConfig),
    );

    await storage.create(tournament);
  }
}
