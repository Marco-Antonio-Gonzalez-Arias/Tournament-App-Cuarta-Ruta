import 'package:cuarta_ruta_app/core/providers/tournament_provider.dart';
import 'package:cuarta_ruta_app/models/tournament_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cuarta_ruta_app/core/widgets/counter_selector_widget.dart';
import 'package:cuarta_ruta_app/core/helpers/phase_generator_helper.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';

class RoundsWidget extends StatelessWidget {
  const RoundsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final res = ResponsiveUtil.of(context);
    final theme = Theme.of(context);
    final provider = context.watch<TournamentProvider>();
    final phases = PhaseGeneratorHelper.generate(provider.selectedPhase, provider.hasThirdPlace);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: res.wp(10)),
      child: Column(
        children: [
          Text(
            'Rondas por fase',
            textAlign: TextAlign.center,
            style: theme.textTheme.titleSmall?.copyWith(color: theme.colorScheme.onSurface),
          ),
          SizedBox(height: res.hp(1)),
          ...phases.map((phase) {
            return Padding(
              padding: EdgeInsets.only(bottom: res.hp(2)),
              child: CounterSelectorWidget(
                label: phase.displayName,
                count: provider.roundsConfig[phase] ?? 1,
                onIncrement: () => provider.updateSingleRound(phase, 1),
                onDecrement: () => provider.updateSingleRound(phase, -1),
                min: 1,
                max: 5,
                textStyle: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurface),
              ),
            );
          }),
        ],
      ),
    );
  }
}