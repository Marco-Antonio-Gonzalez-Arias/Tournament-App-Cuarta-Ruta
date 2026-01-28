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
          ..._buildPhaseSelectors(context, provider, phases),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      'Rondas por fase',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }

  List<Widget> _buildPhaseSelectors(
    BuildContext context,
    TournamentCreationProvider provider,
    List<PhasesEnum> phases,
  ) {
    return phases
        .map((phase) => _buildCounterItem(context, provider, phase))
        .toList();
  }

  Widget _buildCounterItem(
    BuildContext context,
    TournamentCreationProvider provider,
    PhasesEnum phase,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.res.hp(2)),
      child: CounterSelectorWidget(
        label: phase.displayName,
        count: provider.roundsConfig[phase] ?? 1,
        onIncrement: () => provider.updateSingleRound(phase, 1),
        onDecrement: () => provider.updateSingleRound(phase, -1),
        min: 1,
        max: 5,
        textStyle: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }
}
