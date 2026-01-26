import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cuarta_ruta_app/core/config/theme/app_colors.dart';
import 'package:cuarta_ruta_app/core/enums/phases_enum.dart';
import 'package:cuarta_ruta_app/core/providers/tournament_list_provider.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';
import 'package:cuarta_ruta_app/core/widgets/tournament_info_row_widget.dart';
import 'package:cuarta_ruta_app/core/widgets/button_widget.dart';
import 'package:cuarta_ruta_app/core/widgets/confirm_modal_widget.dart';
import 'package:cuarta_ruta_app/models/tournament_base.dart';
import 'package:cuarta_ruta_app/models/impl/knockout_tournament_model.dart';
import 'package:cuarta_ruta_app/models/impl/league_tournament_model.dart';
import 'package:cuarta_ruta_app/screens/tournament/list/widgets/tournament_tile_header_widget.dart';

class TournamentTileWidget extends StatelessWidget {
  final TournamentBase tournament;
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
      childrenPadding: EdgeInsets.symmetric(
        horizontal: context.res.wp(4),
        vertical: context.res.hp(1),
      ),
      expandedCrossAxisAlignment: CrossAxisAlignment.center,
      children: _buildChildren(context),
    );
  }

  List<Widget> _buildChildren(BuildContext context) {
    final List<Widget> children = [
      _buildSectionLabel(context, "Ajustes generales"),
      TournamentInfoRowWidget(
        label: "Tipo",
        value: tournament.type.name.toUpperCase(),
      ),
      TournamentInfoRowWidget(
        label: "Réplicas permitidas",
        value: "${tournament.replicaCount}",
      ),
    ];

    if (tournament is KnockoutTournamentModel) {
      final model = tournament as KnockoutTournamentModel;
      children.addAll([
        TournamentInfoRowWidget(
          label: "Fase inicial",
          value: model.startPhase.displayName,
        ),
        const Divider(),
        _buildSectionLabel(context, "Rondas por fase"),
        ...model.roundsConfig.entries.map(
          (e) => TournamentInfoRowWidget(
            label: e.key.displayName,
            value: "${e.value}",
          ),
        ),
      ]);
    } else if (tournament is LeagueTournamentModel) {
      final model = tournament as LeagueTournamentModel;
      children.addAll([
        TournamentInfoRowWidget(
          label: "Participantes",
          value: "${model.participantCount}",
        ),
        TournamentInfoRowWidget(
          label: "Batallas x Part.",
          value: "${model.battlesPerParticipant}",
        ),
        TournamentInfoRowWidget(
          label: "Rondas x Batalla",
          value: "${model.roundsPerBattle}",
        ),
      ]);
    }

    children.addAll([
      _buildActionRow(context),
      _buildGoToTournamentButton(context),
    ]);

    return children;
  }

  Widget _buildActionRow(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _buildIconButton(context, Icons.edit, () {}),
      _buildIconButton(context, Icons.delete, () => _onDeletePressed(context)),
    ],
  );

  void _onDeletePressed(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => ConfirmModalWidget(
        title: "Confirmar",
        message: "¿Deseas eliminar \"${tournament.name}\"?",
        confirmLabel: "Eliminar",
      ),
    );

    if (confirmed == true && context.mounted) {
      context.read<TournamentListProvider>().deleteTournament(tournament.id);
    }
  }

  Widget _buildIconButton(
    BuildContext context,
    IconData icon,
    VoidCallback onPressed,
  ) => IconButton(
    icon: Icon(icon, size: context.res.dp(2.5)),
    color: Theme.of(context).colorScheme.primary,
    onPressed: onPressed,
  );

  Widget _buildSectionLabel(BuildContext context, String text) => Padding(
    padding: EdgeInsets.symmetric(vertical: context.res.hp(0.5)),
    child: Text(text, style: Theme.of(context).textTheme.labelMedium),
  );

  Widget _buildGoToTournamentButton(BuildContext context) => ButtonWidget(
    label: "Iniciar",
    onPressed: () {},
    height: context.res.hp(5),
    backgroundColor: AppColors.primaryColor,
    textStyle: Theme.of(
      context,
    ).textTheme.bodySmall?.copyWith(color: AppColors.onPrimary),
  );
}
