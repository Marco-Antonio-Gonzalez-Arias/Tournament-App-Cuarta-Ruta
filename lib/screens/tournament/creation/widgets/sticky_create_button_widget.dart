import 'package:cuarta_ruta_app/core/config/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cuarta_ruta_app/core/providers/tournament_creation_provider.dart';
import 'package:cuarta_ruta_app/core/services/tournament_storage_base.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';
import 'package:cuarta_ruta_app/core/widgets/button_widget.dart';
import 'package:cuarta_ruta_app/core/widgets/input_modal_widget.dart';

class StickyCreateButtonWidget extends StatelessWidget {
  const StickyCreateButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _getPadding(context),
      child: _buildCreateButton(context),
    );
  }

  EdgeInsets _getPadding(BuildContext context) => EdgeInsets.symmetric(
    horizontal: context.res.wp(10),
    vertical: context.res.hp(2),
  );

  Widget _buildCreateButton(BuildContext context) {
    final provider = context.watch<TournamentCreationProvider>();
    return ButtonWidget(
      label: 'Crear',
      onPressed: () => _handlePress(context, provider),
      textStyle: Theme.of(context).textTheme.bodySmall,
    );
  }

  Future<void> _handlePress(
    BuildContext context,
    TournamentCreationProvider provider,
  ) async {
    final name = await _showNameModal(context);
    if (name != null && context.mounted) {
      await _processSave(context, provider, name);
    }
  }

  Future<String?> _showNameModal(BuildContext context) => showDialog<String>(
    context: context,
    builder: (_) => const InputModalWidget(title: 'Nombre del Torneo'),
  );

  Future<void> _processSave(
    BuildContext context,
    TournamentCreationProvider provider,
    String name,
  ) async {
    final storage = context.read<TournamentStorageBase>();
    await provider.createTournament(name, storage);
    if (context.mounted) _navigateToList(context);
  }

  void _navigateToList(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.tournamentList,
      ModalRoute.withName(AppRoutes.tournamentMenu),
    );
  }
}
