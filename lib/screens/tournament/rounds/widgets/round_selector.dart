import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/utils/responsive.dart';
import 'package:cuarta_ruta_app/core/config/theme/app_colors.dart';
import 'package:cuarta_ruta_app/models/tournament_model.dart';

class RoundSelector extends StatelessWidget {
  final Phases phase;
  final int rounds;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const RoundSelector({super.key, required this.phase, required this.rounds, required this.onIncrement, required this.onDecrement});

  @override
  Widget build(BuildContext context) {
    final res = Responsive.of(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryGold, width: 3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          _buildBtn(Icons.remove, onDecrement, res),
          Expanded(
            child: Container(
              height: res.hp(8),
              color: AppColors.backgroundBlack,
              alignment: Alignment.center,
              child: Text(_getDisplayName(phase), style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primaryWhite)),
            ),
          ),
          Container(
            width: res.wp(15),
            height: res.hp(8),
            color: AppColors.primaryGold,
            alignment: Alignment.center,
            child: Text('$rounds', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.backgroundBlack, fontWeight: FontWeight.bold)),
          ),
          _buildBtn(Icons.add, onIncrement, res),
        ],
      ),
    );
  }

  Widget _buildBtn(IconData icon, VoidCallback action, Responsive res) {
    return GestureDetector(
      onTap: action,
      child: Container(
        width: res.wp(12),
        height: res.hp(8),
        color: AppColors.backgroundBlack,
        child: Icon(icon, color: AppColors.primaryGold, size: res.dp(3)),
      ),
    );
  }

  String _getDisplayName(Phases p) {
    if (p == Phases.faseFinal) return 'FINAL';
    if (p == Phases.tercerPuesto) return '3ER/4TO';
    return p.name.toUpperCase();
  }
}