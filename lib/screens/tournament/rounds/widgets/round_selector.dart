import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/utils/responsive.dart';
import 'package:cuarta_ruta_app/core/config/theme/app_colors.dart';

class RoundSelector extends StatelessWidget {
  final String phase;
  final int rounds;

  const RoundSelector({
    super.key,
    required this.phase,
    required this.rounds,
  });

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
          Expanded(
            child: Container(
              height: responsive.hp(8),
              color: AppColors.backgroundBlack,
              alignment: Alignment.center,
              child: Text(
                phase,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.primaryWhite,
                    ),
              ),
            ),
          ),
          Container(
            width: responsive.wp(20),
            height: responsive.hp(8),
            color: AppColors.primaryGold,
            alignment: Alignment.center,
            child: Text(
              '$rounds',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.backgroundBlack,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}