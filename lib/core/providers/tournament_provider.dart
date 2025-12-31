import 'package:cuarta_ruta_app/models/tournament_model.dart';
import 'package:flutter/material.dart';

class TournamentProvider extends ChangeNotifier {
  Phases _selectedPhase = Phases.octavos;
  bool _hasThirdPlace = false;
  bool _hasReplica = true;
  final Map<Phases, int> _roundsConfig = {};

  Phases get selectedPhase => _selectedPhase;
  bool get hasThirdPlace => _hasThirdPlace;
  bool get hasReplica => _hasReplica;
  Map<Phases, int> get roundsConfig => _roundsConfig;

  void updateSettings(Phases phase, bool third, bool replica) {
    _selectedPhase = phase;
    _hasThirdPlace = third;
    _hasReplica = replica;
    notifyListeners();
  }

  void updateRounds(Map<Phases, int> config) {
    _roundsConfig.clear();
    _roundsConfig.addAll(config);
    notifyListeners();
  }

  void updateSingleRound(Phases phase, int delta) {
  final currentCount = _roundsConfig[phase] ?? 1;
  _roundsConfig[phase] = (currentCount + delta).clamp(1, 5);
  notifyListeners();
}
}