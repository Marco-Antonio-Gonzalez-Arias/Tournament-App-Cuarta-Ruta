import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/enums/phases.dart';
import 'package:cuarta_ruta_app/models/tournament_base.dart';

class TournamentTileHeader extends StatelessWidget {
  final TournamentBase tournament;
  final ExpansibleController controller;

  const TournamentTileHeader({
    super.key,
    required this.tournament,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) => Column(
        children: [
          _buildName(context),
          if (!controller.isExpanded) _buildInitialPhase(context),
        ],
      ),
    );
  }

  Widget _buildName(BuildContext context) => Text(
    tournament.name,
    textAlign: TextAlign.center,
    style: Theme.of(
      context,
    ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
  );

  Widget _buildInitialPhase(BuildContext context) => Text(
    "Fase inicial: ${tournament.startPhase.displayName}",
    style: Theme.of(context).textTheme.labelMedium,
  );
}
