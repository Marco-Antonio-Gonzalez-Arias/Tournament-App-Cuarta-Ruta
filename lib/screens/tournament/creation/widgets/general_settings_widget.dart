import 'package:cuarta_ruta_app/core/providers/tournament_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cuarta_ruta_app/core/widgets/dropdown_widget.dart';
import 'package:cuarta_ruta_app/core/widgets/toggle_option_widget.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';
import 'package:cuarta_ruta_app/models/tournament_model.dart';

class GeneralSettingsWidget extends StatelessWidget {
  const GeneralSettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final res = ResponsiveUtil.of(context);
    final theme = Theme.of(context);
    final provider = context.watch<TournamentProvider>();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: res.wp(10)),
      child: Column(
        children: [
          Text(
            'Configuración General',
            textAlign: TextAlign.center,
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: res.hp(1)),
          DropdownWidget<Phases>(
            label: 'Fases',
            value: provider.selectedPhase,
            items: const [Phases.octavos, Phases.cuartos, Phases.semifinales],
            itemLabelBuilder: (phase) => phase.displayName,
            onChanged: (val) {
              if (val != null) {
                provider.updateSettings(
                  val,
                  provider.hasThirdPlace,
                  provider.hasReplica,
                );
              }
            },
            textStyle: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: res.hp(1)),
          _buildOptions(context, res, theme, provider),
          SizedBox(height: res.hp(1)),
        ],
      ),
    );
  }

  Widget _buildOptions(
    BuildContext context,
    ResponsiveUtil res,
    ThemeData theme,
    TournamentProvider provider,
  ) {
    final style = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurface,
    );
    return Column(
      children: [
        ToggleOptionWidget(
          label: '3er Puesto',
          value: provider.hasThirdPlace,
          onChanged: (val) => provider.updateSettings(
            provider.selectedPhase,
            val,
            provider.hasReplica,
          ),
          textStyle: style,
        ),
        SizedBox(height: res.hp(1)),
        ToggleOptionWidget(
          label: 'Réplica',
          value: provider.hasReplica,
          onChanged: (val) => provider.updateSettings(
            provider.selectedPhase,
            provider.hasThirdPlace,
            val,
          ),
          textStyle: style,
        ),
      ],
    );
  }
}
