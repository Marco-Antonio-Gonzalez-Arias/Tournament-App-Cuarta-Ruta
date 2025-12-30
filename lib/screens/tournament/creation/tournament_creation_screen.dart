import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cuarta_ruta_app/core/providers/tournament_provider.dart';
import 'package:cuarta_ruta_app/core/widgets/app_bar/app_bar_widget.dart';
import 'package:cuarta_ruta_app/core/widgets/button_widget.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';
import 'package:cuarta_ruta_app/models/tournament_model.dart';
import 'package:cuarta_ruta_app/core/services/tournament_storage_service.dart';
import 'package:cuarta_ruta_app/screens/tournament/creation/widgets/general_settings_widget.dart';
import 'package:cuarta_ruta_app/screens/tournament/creation/widgets/rounds_widget.dart';

class TournamentCreationScreen extends StatelessWidget {
  const TournamentCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TournamentProvider(),
      child: Scaffold(
        appBar: const AppBarWidget(title: "Configurar Torneo"),
        body: const SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [GeneralSettingsWidget(), Divider(), RoundsWidget()],
          ),
        ),
        bottomNavigationBar: const _StickyCreateButton(),
      ),
    );
  }
}

class _StickyCreateButton extends StatelessWidget {
  const _StickyCreateButton();

  Future<void> _showNameModal(
    BuildContext context,
    TournamentProvider provider,
  ) async {
    final controller = TextEditingController();
    final theme = Theme.of(context);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: theme.colorScheme.surface,
        title: Text('Nombre del Torneo', style: theme.textTheme.titleSmall),
        content: TextField(
          controller: controller,
          style: theme.textTheme.bodySmall,
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Nombre...",
            hintStyle: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withAlpha(50),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar', style: theme.textTheme.bodySmall),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                Navigator.pop(context);
                _handleSave(context, provider, controller.text.trim());
              }
            },
            child: Text(
              'Guardar',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSave(
    BuildContext context,
    TournamentProvider provider,
    String name,
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
