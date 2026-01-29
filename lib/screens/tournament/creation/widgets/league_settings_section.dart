import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/providers/tournament_creation_provider.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';
import 'package:cuarta_ruta_app/core/widgets/counter_selector_widget.dart';
import 'package:cuarta_ruta_app/core/widgets/dropdown_widget.dart';
import 'package:cuarta_ruta_app/core/enums/league_mode_enum.dart';

class LeagueSettingsSection extends StatelessWidget {
  final TournamentCreationProvider provider;
  final TextStyle? style;

  const LeagueSettingsSection({super.key, required this.provider, this.style});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: context.res.hp(1)),
        DropdownWidget<LeagueModeEnum>(
          label: 'Configuración de Liga',
          value: provider.leagueMode,
          items: LeagueModeEnum.values,
          itemLabelBuilder: (mode) => mode.displayName,
          onChanged: (val) {
            if (val != null) {
              provider.updateSettings(
                battles: val.battles,
                extra: val.extraPlayer,
              );
            }
          },
          textStyle: style,
          menuTextStyle: Theme.of(context).textTheme.labelSmall,
        ),
        SizedBox(height: context.res.hp(1)),
        CounterSelectorWidget(
          label: 'Participantes',
          count: provider.participantCount,
          onIncrement: () => provider.updateSettings(
            participants:
                provider.participantCount +
                TournamentCreationProvider.stepParticipants,
          ),
          onDecrement: () => provider.updateSettings(
            participants:
                provider.participantCount -
                TournamentCreationProvider.stepParticipants,
          ),
          min: TournamentCreationProvider.minParticipants,
          max: TournamentCreationProvider.maxParticipants,
          textStyle: style,
        ),
        SizedBox(height: context.res.hp(1)),
        CounterSelectorWidget(
          label: 'Rondas por batalla',
          count: provider.roundsPerBattle,
          onIncrement: () =>
              provider.updateSettings(rounds: provider.roundsPerBattle + 1),
          onDecrement: () =>
              provider.updateSettings(rounds: provider.roundsPerBattle - 1),
          min: TournamentCreationProvider.minRounds,
          max: TournamentCreationProvider.maxRounds,
          textStyle: style,
        ),
      ],
    );
  }
}
