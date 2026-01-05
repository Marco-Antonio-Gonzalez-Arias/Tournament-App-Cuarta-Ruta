import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cuarta_ruta_app/core/config/theme/app_colors.dart';
import 'package:cuarta_ruta_app/core/providers/tournament_list_provider.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';
import 'package:cuarta_ruta_app/core/enums/phases_enum.dart';
import 'package:cuarta_ruta_app/core/widgets/tournament_info_row_widget.dart';
import 'package:cuarta_ruta_app/core/widgets/button_widget.dart';
import 'package:cuarta_ruta_app/core/widgets/confirm_modal_widget.dart';
import 'package:cuarta_ruta_app/models/impl/tournament_model.dart';
import 'package:cuarta_ruta_app/models/tournament_base.dart';
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
    _buildActionRow(context),
    _buildGoToTournamentButton(context),
  ];

  Widget _buildActionRow(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _buildIconButton(context, Icons.edit, () {}),
      _buildIconButton(context, Icons.delete, () => _onDeletePressed(context)),
    ],
  );

  void _onDeletePressed(BuildContext context) async {
    final model = _getValidModel();
    if (model == null) return;

    final confirmed = await _showConfirmDialog(context);

    if (confirmed == true && context.mounted) {
      context.read<TournamentListProvider>().deleteTournament(model.id);
    }
  }

  TournamentModel? _getValidModel() =>
      tournament is TournamentModel ? tournament as TournamentModel : null;

  Future<bool?> _showConfirmDialog(BuildContext context) => showDialog<bool>(
    context: context,
    builder: (context) => const ConfirmModalWidget(
      title: "Confirmar",
      message: "¿Deseas eliminar este torneo de tu lista?",
    ),
  );

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

  List<Widget> _buildRoundsList() => tournament.roundsConfig.entries
      .map(
        (e) => TournamentInfoRowWidget(
          label: e.key.displayName,
          value: "${e.value}",
        ),
      )
      .toList();

  Widget _buildGoToTournamentButton(BuildContext context) => ButtonWidget(
    label: "Iniciar",
    onPressed: () {},
    height: context.res.hp(5),
    backgroundColor: AppColors.primaryColor,
    overlayColor: AppColors.onPrimary.withAlpha(20),
    textStyle: Theme.of(
      context,
    ).textTheme.bodySmall?.copyWith(color: AppColors.onPrimary),
  );
}
