import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';
import 'package:cuarta_ruta_app/core/widgets/tournament_info_row_widget.dart';
import 'package:cuarta_ruta_app/models/tournament_model.dart';
import 'package:cuarta_ruta_app/screens/tournament/list/widgets/tournament_tile_header.dart';

class TournamentTileWidget extends StatelessWidget {
  final TournamentModel tournament;
  final ExpansibleController? controller;
  final ValueChanged<bool>? onExpansionChanged;

  const TournamentTileWidget({
    super.key,
    required this.tournament,
    this.controller,
    this.onExpansionChanged,
  });

  @override
  Widget build(BuildContext context) {
    final activeController = controller ?? ExpansibleController();

    return ExpansionTile(
      controller: activeController,
      onExpansionChanged: onExpansionChanged,
      shape: const Border(),
      title: TournamentTileHeader(
        tournament: tournament,
        controller: activeController,
      ),
      childrenPadding: _getPadding(context),
      expandedCrossAxisAlignment: CrossAxisAlignment.center,
      children: _buildChildren(context),
    );
  }

  EdgeInsets _getPadding(BuildContext context) => EdgeInsets.symmetric(
    horizontal: context.res.wp(4),
    vertical: context.res.hp(1),
  );

  List<Widget> _buildChildren(BuildContext context) => [
    _buildSectionLabel(context, "Ajustes generales"),
    TournamentInfoRowWidget(
      label: "Fase inicial",
      value: tournament.startPhase.displayName,
    ),
    TournamentInfoRowWidget(
      label: "Réplica",
      value: tournament.hasReplica ? "Sí" : "No",
    ),
    Divider(height: context.res.hp(2)),
    _buildSectionLabel(context, "Rondas por fase"),
    ..._buildRoundsList(),
  ];

  Widget _buildSectionLabel(BuildContext context, String text) => Padding(
    padding: EdgeInsets.symmetric(vertical: context.res.hp(0.5)),
    child: Text(text, style: Theme.of(context).textTheme.labelMedium),
  );

  List<Widget> _buildRoundsList() => tournament.roundsConfig.entries
      .map(
        (e) => TournamentInfoRowWidget(
          label: e.key.displayName,
          value: "${e.value}",
        ),
      )
      .toList();
}
