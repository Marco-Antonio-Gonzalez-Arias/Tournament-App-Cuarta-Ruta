import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/providers/tournament_creation_provider.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';
import 'package:cuarta_ruta_app/core/enums/phases_enum.dart';
import 'package:cuarta_ruta_app/core/widgets/dropdown_widget.dart';
import 'package:cuarta_ruta_app/core/widgets/toggle_option_widget.dart';

class KnockoutSettingsSection extends StatelessWidget {
  final TournamentCreationProvider provider;
  final TextStyle? style;

  const KnockoutSettingsSection({
    super.key,
    required this.provider,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: context.res.hp(1)),
        ToggleOptionWidget(
          label: 'Comodín',
          value: provider.hasWildcard,
          onChanged: (val) => provider.updateSettings(wildcard: val),
          textStyle: style,
          tooltip:
              'El último participante de la ruleta puede elegir una posición ocupada del bracket.',
        ),
        SizedBox(height: context.res.hp(1)),
        DropdownWidget<PhasesEnum>(
          label: 'Fase Inicial',
          value: provider.selectedPhase,
          items: const [
            PhasesEnum.roundOf16,
            PhasesEnum.quarterFinals,
            PhasesEnum.semifinals,
          ],
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
      ],
    );
  }
}
