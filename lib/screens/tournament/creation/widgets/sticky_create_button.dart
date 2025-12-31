import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cuarta_ruta_app/core/providers/tournament_provider.dart';
import 'package:cuarta_ruta_app/core/services/tournament_storage_service.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';
import 'package:cuarta_ruta_app/core/widgets/button_widget.dart';
import 'package:cuarta_ruta_app/core/widgets/name_input_modal.dart';
import 'package:cuarta_ruta_app/models/tournament_model.dart';

class StickyCreateButton extends StatelessWidget {
  const StickyCreateButton({super.key});

  Future<void> _showNameModal(BuildContext context, TournamentProvider provider) async {
    final name = await showDialog<String>(
      context: context,
      builder: (context) => const NameInputModal(title: 'Nombre del Torneo'),
    );

    if (name != null && context.mounted) {
      _handleSave(context, provider, name);
    }
  }

  Future<void> _handleSave(
    BuildContext context, 
    TournamentProvider provider, 
    String name
  ) async {
    final tournament = TournamentModel(
      name: name,
      startPhase: provider.selectedPhase,
      hasThirdPlace: provider.hasThirdPlace,
      hasReplica: provider.hasReplica,
      roundsConfig: provider.roundsConfig,
    );

    await TournamentStorageService().create(tournament);

    if (context.mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final res = ResponsiveUtil.of(context);
    final theme = Theme.of(context);
    final provider = context.watch<TournamentProvider>();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: res.wp(10),
        vertical: res.hp(2),
      ),
      child: ButtonWidget(
        label: 'Crear',
        onPressed: () => _showNameModal(context, provider),
        textStyle: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurface,
        ),
      ),
    );
  }
}