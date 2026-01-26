import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/enums/phases_enum.dart';
import 'package:cuarta_ruta_app/models/tournament_base.dart';
import 'package:cuarta_ruta_app/models/impl/knockout_tournament_model.dart';

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
          if (!controller.isExpanded) _buildSubheader(context),
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

  Widget _buildSubheader(BuildContext context) {
    String text = "";
    if (tournament is KnockoutTournamentModel) {
      text =
          "Fase inicial: ${(tournament as KnockoutTournamentModel).startPhase.displayName}";
    } else {
      text = "Tipo: Liga";
    }

    return Text(text, style: Theme.of(context).textTheme.labelMedium);
  }
}
