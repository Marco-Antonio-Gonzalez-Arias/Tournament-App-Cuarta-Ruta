import 'package:cuarta_ruta_app/core/widgets/dropdown.dart';
import 'package:cuarta_ruta_app/core/widgets/toggle_option.dart';
import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/utils/responsive.dart';
import 'package:cuarta_ruta_app/models/tournament_model.dart';
import 'package:cuarta_ruta_app/screens/tournament/widgets/page_indicators_row.dart';

class PhasesScreen extends StatefulWidget {
  final Function(Phases, bool, bool) onNext;
  const PhasesScreen({super.key, required this.onNext});

  @override
  State<PhasesScreen> createState() => _PhasesScreenState();
}

class _PhasesScreenState extends State<PhasesScreen> {
  Phases _selectedPhase = Phases.octavos;
  bool _hasThirdPlace = false;
  bool _hasReplica = false;

  void _handleSwipe(DragEndDetails details) {
    if (details.primaryVelocity! < 0) {
      widget.onNext(_selectedPhase, _hasThirdPlace, _hasReplica);
    }
  }

  @override
  Widget build(BuildContext context) {
    final res = Responsive.of(context);
    final theme = Theme.of(context);

    return GestureDetector(
      onHorizontalDragEnd: _handleSwipe,
      child: Container(
        color: theme.scaffoldBackgroundColor,
        padding: EdgeInsets.symmetric(horizontal: res.wp(10), vertical: res.hp(5)),
        child: Column(
          children: [
            _buildHeader(theme),
            SizedBox(height: res.hp(5)),
            _buildPhaseSelector(theme),
            SizedBox(height: res.hp(3)),
            _buildOptions(res, theme),
            const Spacer(),
            const PageIndicatorsRow(currentPage: 0, totalPages: 2),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Text(
      'General',
      style: theme.textTheme.titleSmall?.copyWith(
        color: theme.colorScheme.onSurface,
      ),
    );
  }

  Widget _buildPhaseSelector(ThemeData theme) {
    return Dropdown<Phases>(
      label: 'Fases',
      value: _selectedPhase,
      items: const [Phases.octavos, Phases.cuartos, Phases.semifinales],
      itemLabelBuilder: (phase) => phase.name,
      onChanged: (newValue) {
        if (newValue != null) setState(() => _selectedPhase = newValue);
      },
      textStyle: theme.textTheme.bodySmall?.copyWith(
        color: theme.colorScheme.onSurface,
      ),
    );
  }

  Widget _buildOptions(Responsive res, ThemeData theme) {
    final style = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurface,
    );

    return Column(
      children: [
        ToggleOption(
          label: '3er/4to',
          value: _hasThirdPlace,
          onChanged: (val) => setState(() => _hasThirdPlace = val),
          textStyle: style,
        ),
        SizedBox(height: res.hp(3)),
        ToggleOption(
          label: 'Réplica',
          value: _hasReplica,
          onChanged: (val) => setState(() => _hasReplica = val),
          textStyle: style,
        ),
      ],
    );
  }
}