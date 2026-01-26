import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cuarta_ruta_app/core/providers/tournament_provider.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';
import 'package:cuarta_ruta_app/core/enums/phases_enum.dart';
import 'package:cuarta_ruta_app/core/enums/tournament_type_enum.dart';
import 'package:cuarta_ruta_app/core/widgets/dropdown_widget.dart';
import 'package:cuarta_ruta_app/core/widgets/toggle_option_widget.dart';
import 'package:cuarta_ruta_app/core/widgets/counter_selector_widget.dart';

class GeneralSettingsWidget extends StatelessWidget {
  const GeneralSettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TournamentProvider>();
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
            _buildKnockoutSettings(context, provider, style)
          else
            _buildLeagueSettings(context, provider, style),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context, String text) {
    return Text(text, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium);
  }

  Widget _buildTypeDropdown(BuildContext context, TournamentProvider provider) {
    return DropdownWidget<TournamentTypeEnum>(
      label: 'Tipo de Torneo',
      value: provider.type,
      items: TournamentTypeEnum.values,
      itemLabelBuilder: (type) => type == TournamentTypeEnum.knockout ? 'Eliminatorias' : 'Liga',
      onChanged: (val) => provider.updateSettings(type: val),
      textStyle: Theme.of(context).textTheme.labelLarge,
    );
  }

  Widget _buildCommonSettings(BuildContext context, TournamentProvider provider, TextStyle? style) {
    return Column(
      children: [
        CounterSelectorWidget(
          label: 'Dif. Puntos',
          count: provider.pointsDifference,
          onIncrement: () => provider.updateSettings(pointsDiff: provider.pointsDifference + 1),
          onDecrement: () => provider.updateSettings(pointsDiff: (provider.pointsDifference - 1).clamp(1, 10)),
          textStyle: style,
        ),
        SizedBox(height: context.res.hp(1)),
        CounterSelectorWidget(
          label: 'Réplicas',
          count: provider.replicaCount,
          onIncrement: () => provider.updateSettings(replicas: provider.replicaCount + 1),
          onDecrement: () => provider.updateSettings(replicas: (provider.replicaCount - 1).clamp(0, 5)),
          textStyle: style,
        ),
      ],
    );
  }

  Widget _buildKnockoutSettings(BuildContext context, TournamentProvider provider, TextStyle? style) {
    return Column(
      children: [
        SizedBox(height: context.res.hp(1)),
        DropdownWidget<PhasesEnum>(
          label: 'Fase Inicial',
          value: provider.selectedPhase,
          items: const [PhasesEnum.roundOf16, PhasesEnum.quarterFinals, PhasesEnum.semifinals],
          itemLabelBuilder: (phase) => phase.displayName,
          onChanged: (val) => provider.updateSettings(phase: val),
          textStyle: style,
        ),
        SizedBox(height: context.res.hp(1)),
        ToggleOptionWidget(
          label: '3er Puesto',
          value: provider.hasThirdPlace,
          onChanged: (val) => provider.updateSettings(thirdPlace: val),
          textStyle: style,
        ),
        SizedBox(height: context.res.hp(1)),
        ToggleOptionWidget(
          label: 'Comodín',
          value: provider.hasWildcard,
          onChanged: (val) => provider.updateSettings(wildcard: val),
          textStyle: style,
        ),
      ],
    );
  }

  Widget _buildLeagueSettings(BuildContext context, TournamentProvider provider, TextStyle? style) {
    return Column(
      children: [
        SizedBox(height: context.res.hp(1)),
        CounterSelectorWidget(
          label: 'Participantes',
          count: provider.participantCount,
          onIncrement: () => provider.updateSettings(participants: provider.participantCount + 1),
          onDecrement: () => provider.updateSettings(participants: (provider.participantCount - 1).clamp(2, 32)),
          textStyle: style,
        ),
        SizedBox(height: context.res.hp(1)),
        CounterSelectorWidget(
          label: 'Batallas x Part.',
          count: provider.battlesPerParticipant,
          onIncrement: () => provider.updateSettings(battles: provider.battlesPerParticipant + 1),
          onDecrement: () => provider.updateSettings(battles: (provider.battlesPerParticipant - 1).clamp(1, 10)),
          textStyle: style,
        ),
        SizedBox(height: context.res.hp(1)),
        CounterSelectorWidget(
          label: 'Rondas x Batalla',
          count: provider.roundsPerBattle,
          onIncrement: () => provider.updateSettings(rounds: provider.roundsPerBattle + 1),
          onDecrement: () => provider.updateSettings(rounds: (provider.roundsPerBattle - 1).clamp(1, 5)),
          textStyle: style,
        ),
        SizedBox(height: context.res.hp(1)),
        ToggleOptionWidget(
          label: 'Extra Player',
          value: provider.extraPlayer,
          onChanged: (val) => provider.updateSettings(extra: val),
          textStyle: style,
        ),
      ],
    );
  }
}