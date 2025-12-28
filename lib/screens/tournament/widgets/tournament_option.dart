import 'package:cuarta_ruta_app/core/widgets/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/utils/responsive.dart';
import 'package:cuarta_ruta_app/core/config/theme/app_colors.dart';
import 'option_background.dart';

class TournamentOption extends StatelessWidget {
  final String _imagePath;
  final String _label;
  final VoidCallback _onTap;

  const TournamentOption({
    super.key,
    required String imagePath,
    required String label,
    required VoidCallback onTap,
  })  : _imagePath = imagePath,
        _label = label,
        _onTap = onTap;

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final double innerPadding = responsive.dp(1.3);

    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: innerPadding),
        child: ClipRect(
          child: Stack(
            fit: StackFit.expand,
            children: [
              OptionBackground(imagePath: _imagePath),
              Center(
                child: IgnorePointer(
                  child: BorderedText(
                    text: _label,
                    style: Theme.of(context).textTheme.displayLarge,
                    strokeWidth: responsive.dp(2),
                    strokeColor: AppColors.backgroundBlack,
                    fillColor: AppColors.primaryGold,
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _onTap,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}