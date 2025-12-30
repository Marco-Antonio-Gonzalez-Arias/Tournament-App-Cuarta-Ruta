import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/utils/responsive.dart';
import 'package:cuarta_ruta_app/core/config/theme/app_colors.dart';
import 'package:cuarta_ruta_app/models/tournament_model.dart';

class PhaseDropdown extends StatelessWidget {
  final Phases? selectedPhase;
  final ValueChanged<Phases?> onChanged;

  const PhaseDropdown({super.key, required this.selectedPhase, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryGold, width: 3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: responsive.wp(20),
            height: responsive.hp(8),
            color: AppColors.primaryGold,
            child: Icon(Icons.arrow_drop_down, size: responsive.dp(5), color: AppColors.backgroundBlack),
          ),
          Expanded(
            child: Container(
              height: responsive.hp(8),
              color: AppColors.backgroundBlack,
              alignment: Alignment.center,
              child: DropdownButton<Phases>(
                value: selectedPhase,
                hint: Text('OCTAVOS', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primaryWhite)),
                isExpanded: true,
                underline: const SizedBox(),
                dropdownColor: AppColors.backgroundBlack,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primaryWhite),
                items: Phases.values.map((phase) {
                  return DropdownMenuItem(
                    value: phase,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: responsive.wp(5)),
                      child: Text(_getDisplayName(phase)),
                    ),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getDisplayName(Phases p) {
    if (p == Phases.faseFinal) return 'FINAL';
    if (p == Phases.tercerPuesto) return '3ER/4TO';
    return p.name.toUpperCase();
  }
}