import 'package:cuarta_ruta_app/screens/tournament/phases/widgets/phase_dropdown.dart';
import 'package:cuarta_ruta_app/screens/tournament/phases/widgets/toggle_option.dart';
import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/utils/responsive.dart';
import 'package:cuarta_ruta_app/core/config/theme/app_colors.dart';
import 'package:cuarta_ruta_app/models/tournament_model.dart';
import 'package:cuarta_ruta_app/screens/tournament/widgets/page_indicators_row.dart';

class PhasesScreen extends StatefulWidget {
  final Function(StartingPhase, bool, bool) onNext;

  const PhasesScreen({
    super.key,
    required this.onNext,
  });

  @override
  State<PhasesScreen> createState() => _PhasesScreenState();
}

class _PhasesScreenState extends State<PhasesScreen> {
  StartingPhase? _selectedPhase;
  bool _hasThirdPlace = false;
  bool _hasReplica = false;

  void _handleSwipe(DragEndDetails details) {
    if (details.primaryVelocity! < 0 && _selectedPhase != null) {
      widget.onNext(_selectedPhase!, _hasThirdPlace, _hasReplica);
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return GestureDetector(
      onHorizontalDragEnd: _handleSwipe,
      child: Container(
        color: AppColors.backgroundBlack,
        padding: EdgeInsets.symmetric(
          horizontal: responsive.wp(10),
          vertical: responsive.hp(5),
        ),
        child: Column(
          children: [
            Text(
              'FASES',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: AppColors.primaryWhite,
                  ),
            ),
            SizedBox(height: responsive.hp(5)),
            PhaseDropdown(
              selectedPhase: _selectedPhase,
              onChanged: (value) => setState(() => _selectedPhase = value),
            ),
            SizedBox(height: responsive.hp(3)),
            ToggleOption(
              label: '3ER/4TO',
              value: _hasThirdPlace,
              onChanged: (value) => setState(() => _hasThirdPlace = value),
            ),
            SizedBox(height: responsive.hp(3)),
            ToggleOption(
              label: 'RÉPLICA',
              value: _hasReplica,
              onChanged: (value) => setState(() => _hasReplica = value),
            ),
            const Spacer(),
            const PageIndicatorsRow(currentPage: 0, totalPages: 2),
          ],
        ),
      ),
    );
  }
}