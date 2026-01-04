import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cuarta_ruta_app/core/providers/tournament_provider.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';
import 'package:cuarta_ruta_app/core/enums/phases_enum.dart';
import 'package:cuarta_ruta_app/core/widgets/dropdown_widget.dart';
import 'package:cuarta_ruta_app/core/widgets/toggle_option_widget.dart';

class GeneralSettingsWidget extends StatelessWidget {
  const GeneralSettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TournamentProvider>();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.res.wp(10)),
      child: Column(
        children: [
          _buildTitle(context),
          SizedBox(height: context.res.hp(1)),
          _buildPhaseDropdown(context, provider),
          SizedBox(height: context.res.hp(1)),
          _buildOptions(context, provider),
          SizedBox(height: context.res.hp(1)),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      'Ajustes Generales',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }

  Widget _buildPhaseDropdown(
    BuildContext context,
    TournamentProvider provider,
  ) {
    return DropdownWidget<PhasesEnum>(
      label: 'Fase Inicial',
      value: provider.selectedPhase,
      items: const [PhasesEnum.octavos, PhasesEnum.cuartos, PhasesEnum.semifinales],
      itemLabelBuilder: (phase) => phase.displayName,
      onChanged: (val) => _updatePhase(provider, val),
      textStyle: Theme.of(context).textTheme.labelLarge,
    );
  }

  void _updatePhase(TournamentProvider provider, PhasesEnum? val) {
    if (val != null) {
      provider.updateSettings(val, provider.hasThirdPlace, provider.hasReplica);
    }
  }

  Widget _buildOptions(BuildContext context, TournamentProvider provider) {
    final style = Theme.of(context).textTheme.labelLarge;
    return Column(
      children: [
        _buildToggle(
          '3er Puesto',
          provider.hasThirdPlace,
          style,
          (val) => provider.updateSettings(
            provider.selectedPhase,
            val,
            provider.hasReplica,
          ),
        ),
        SizedBox(height: context.res.hp(1)),
        _buildToggle(
          'Permitir Réplica',
          provider.hasReplica,
          style,
          (val) => provider.updateSettings(
            provider.selectedPhase,
            provider.hasThirdPlace,
            val,
          ),
        ),
      ],
    );
  }

  Widget _buildToggle(
    String label,
    bool value,
    TextStyle? style,
    ValueChanged<bool> onChanged,
  ) {
    return ToggleOptionWidget(
      label: label,
      value: value,
      onChanged: onChanged,
      textStyle: style,
    );
  }
}
