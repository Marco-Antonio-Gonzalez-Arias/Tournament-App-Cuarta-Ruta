import 'package:cuarta_ruta_app/screens/tournament/creation/phases.dart';
import 'package:cuarta_ruta_app/screens/tournament/creation/rounds.dart';
import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/widgets/app_bar/app_bar.dart';
import 'package:cuarta_ruta_app/models/tournament_model.dart';

class TournamentCreationFlow extends StatefulWidget {
  const TournamentCreationFlow({super.key});

  @override
  State<TournamentCreationFlow> createState() => _TournamentCreationFlowState();
}

class _TournamentCreationFlowState extends State<TournamentCreationFlow> {
  final PageController _pageController = PageController();
  Phases _selectedPhase = Phases.octavos;
  bool _hasThirdPlace = false;
  bool _hasReplica = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _updateTournamentState(Phases phase, bool hasThird, bool hasReplica) {
    setState(() {
      _selectedPhase = phase;
      _hasThirdPlace = hasThird;
      _hasReplica = hasReplica;
    });
  }

  void _navigateToNextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _handlePhaseSelection(Phases phase, bool hasThird, bool hasReplica) {
    _updateTournamentState(phase, hasThird, hasReplica);
    _navigateToNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: "Crear Torneo"),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _buildScreens(),
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      PhasesScreen(onNext: _handlePhaseSelection),
      RoundsScreen(
        startPhase: _selectedPhase,
        hasThirdPlace: _hasThirdPlace,
        hasReplica: _hasReplica,
      ),
    ];
  }
}