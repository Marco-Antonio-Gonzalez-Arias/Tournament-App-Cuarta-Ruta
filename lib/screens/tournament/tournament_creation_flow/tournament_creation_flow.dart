import 'package:cuarta_ruta_app/screens/tournament/phases/phases.dart';
import 'package:cuarta_ruta_app/screens/tournament/rounds/rounds.dart';
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
  StartingPhase? _selectedPhase;
  bool _hasThirdPlace = false;
  bool _hasReplica = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToRounds(StartingPhase phase, bool hasThird, bool hasReplica) {
    setState(() {
      _selectedPhase = phase;
      _hasThirdPlace = hasThird;
      _hasReplica = hasReplica;
    });
    
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: "Crear Torneo"),
      body: PageView(
        controller: _pageController,
        children: [
          PhasesScreen(onNext: _goToRounds),
          if (_selectedPhase != null)
            RoundsScreen(
              startPhase: _selectedPhase!,
              hasThirdPlace: _hasThirdPlace,
              hasReplica: _hasReplica,
            ),
        ],
      ),
    );
  }
}