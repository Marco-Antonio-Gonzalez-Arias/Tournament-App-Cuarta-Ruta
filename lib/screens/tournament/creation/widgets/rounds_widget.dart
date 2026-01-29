import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cuarta_ruta_app/core/providers/tournament_creation_provider.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';
import 'package:cuarta_ruta_app/core/enums/phases_enum.dart';
import 'package:cuarta_ruta_app/core/widgets/counter_selector_widget.dart';

class RoundsWidget extends StatelessWidget {
  const RoundsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TournamentCreationProvider>();
    final phases = PhaseDisplay.getIterable(
      provider.selectedPhase,
      provider.hasThirdPlace,
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.res.wp(10)),
      child: Column(
        children: [
          _buildTitle(context),
          SizedBox(height: context.res.hp(1)),
          ..._buildPhaseList(context, provider, phases),
        ],
      ),
    );
  }

  List<Widget> _buildPhaseList(
    BuildContext context,
    TournamentCreationProvider provider,
    List<PhasesEnum> phases,
  ) {
    return phases.map((phase) {
      return Padding(
        padding: EdgeInsets.only(bottom: context.res.hp(2)),
        child: _buildPhaseSelector(context, provider, phase),
      );
    }).toList();
  }

  Widget _buildPhaseSelector(
    BuildContext context,
    TournamentCreationProvider provider,
    PhasesEnum phase,
  ) {
    return CounterSelectorWidget(
      label: phase.displayName,
      count: provider.roundsConfig[phase] ?? 1,
      onIncrement: () => provider.updateSingleRound(phase, 1),
      onDecrement: () => provider.updateSingleRound(phase, -1),
      min: TournamentCreationProvider.minPhaseRounds,
      max: TournamentCreationProvider.maxPhaseRounds,
      textStyle: Theme.of(context).textTheme.labelLarge,
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      'Rondas por fase',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
