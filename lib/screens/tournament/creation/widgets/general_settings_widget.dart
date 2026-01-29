import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cuarta_ruta_app/core/providers/tournament_creation_provider.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';
import 'package:cuarta_ruta_app/core/enums/tournament_type_enum.dart';
import 'package:cuarta_ruta_app/core/widgets/dropdown_widget.dart';
import 'package:cuarta_ruta_app/core/widgets/counter_selector_widget.dart';
import 'package:cuarta_ruta_app/screens/tournament/creation/widgets/knockout_settings_section.dart';
import 'package:cuarta_ruta_app/screens/tournament/creation/widgets/league_settings_section.dart';

class GeneralSettingsWidget extends StatelessWidget {
  const GeneralSettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TournamentCreationProvider>();
    final style = Theme.of(context).textTheme.labelLarge;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.res.wp(10)),
      child: Column(
        children: [
          _buildTitle(context, 'Ajustes Generales'),
          SizedBox(height: context.res.hp(1)),
          _buildTypeDropdown(context, provider),
          SizedBox(height: context.res.hp(1)),
          _buildCommonSettings(context, provider, style),

          if (provider.type == TournamentTypeEnum.knockout)
            KnockoutSettingsSection(provider: provider, style: style)
          else
            LeagueSettingsSection(provider: provider, style: style),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context, String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }

  Widget _buildTypeDropdown(
    BuildContext context,
    TournamentCreationProvider provider,
  ) {
    return DropdownWidget<TournamentTypeEnum>(
      label: 'Tipo de Torneo',
      value: provider.type,
      items: TournamentTypeEnum.values,
      itemLabelBuilder: (type) => type.displayName,
      onChanged: (val) => provider.updateSettings(type: val),
      textStyle: Theme.of(context).textTheme.labelLarge,
    );
  }

  Widget _buildCommonSettings(
    BuildContext context,
    TournamentCreationProvider provider,
    TextStyle? style,
  ) {
    return Column(
      children: [
        CounterSelectorWidget(
          label: 'Diferencia de puntos',
          count: provider.pointsDifference,
          onIncrement: () => provider.updateSettings(
            pointsDiff: provider.pointsDifference + 0.5,
          ),
          onDecrement: () => provider.updateSettings(
            pointsDiff: provider.pointsDifference - 0.5,
          ),
          min: TournamentCreationProvider.minPointsDiff,
          max: TournamentCreationProvider.maxPointsDiff,
          textStyle: style,
        ),
        SizedBox(height: context.res.hp(1)),
        CounterSelectorWidget(
          label: 'Réplicas',
          count: provider.replicaCount,
          onIncrement: () =>
              provider.updateSettings(replicas: provider.replicaCount + 1),
          onDecrement: () =>
              provider.updateSettings(replicas: provider.replicaCount - 1),
          min: TournamentCreationProvider.minReplicas,
          max: TournamentCreationProvider.maxReplicas,
          textStyle: style,
        ),
      ],
    );
  }
}
