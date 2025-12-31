import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';
import 'package:cuarta_ruta_app/models/tournament_model.dart';
import 'package:flutter/material.dart';

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
    final res = ResponsiveUtil.of(context);

    return ExpansionTile(
      controller: controller,
      onExpansionChanged: onExpansionChanged,
      shape: const Border(),
      title: _buildTitle(context),
      subtitle: _buildSubtitle(context),
      childrenPadding: EdgeInsets.symmetric(
        horizontal: res.wp(4),
        vertical: res.hp(1),
      ),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ..._buildGeneralSettings(context),
        Divider(height: res.hp(2)),
        _buildRoundsHeader(context),
        ..._buildRoundsList(context),
      ],
    );
  }

  Widget _buildTitle(BuildContext context) =>
      Text(tournament.name, style: Theme.of(context).textTheme.bodyMedium);

  Widget _buildSubtitle(BuildContext context) => Text(
    "Fase inicial: ${tournament.startPhase.displayName}",
    style: Theme.of(context).textTheme.bodySmall,
  );

  List<Widget> _buildGeneralSettings(BuildContext context) => [
    _buildInfoRow(context, "Réplica", tournament.hasReplica ? "Sí" : "No"),
  ];

  Widget _buildRoundsHeader(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(vertical: ResponsiveUtil.of(context).hp(0.5)),
    child: Text(
      "Rondas por fase:",
      style: Theme.of(context).textTheme.labelSmall,
    ),
  );

  List<Widget> _buildRoundsList(BuildContext context) => tournament
      .roundsConfig
      .entries
      .map(
        (entry) =>
            _buildInfoRow(context, entry.key.displayName, "${entry.value}"),
      )
      .toList();

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    final res = ResponsiveUtil.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: res.hp(0.3)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodySmall),
          _buildValueText(context, value),
        ],
      ),
    );
  }

  Widget _buildValueText(BuildContext context, String value) {
    final theme = Theme.of(context);
    return Text(
      value,
      style: theme.textTheme.bodySmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.primary,
      ),
    );
  }
}
