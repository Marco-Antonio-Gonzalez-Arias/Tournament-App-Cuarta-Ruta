import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/config/theme/app_colors.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';
import 'package:cuarta_ruta_app/core/widgets/bordered_text_widget.dart';

class MenuOptionWidget extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;

  const MenuOptionWidget({
    super.key,
    required this.imagePath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        _buildBackgroundImage(),
        _buildLabel(context),
        _buildInteractionLayer(),
      ],
    );
  }

  Widget _buildBackgroundImage() => Image.asset(imagePath, fit: BoxFit.cover);

  Widget _buildLabel(BuildContext context) {
    return Center(
      child: IgnorePointer(
        child: BorderedTextWidget(
          text: label,
          style: Theme.of(context).textTheme.displaySmall,
          strokeWidth: context.res.dp(2),
          strokeColor: AppColors.onPrimary,
          fillColor: AppColors.primaryColor,
        ),
      ),
    );
  }

  Widget _buildInteractionLayer() => Material(
    color: Colors.transparent,
    child: InkWell(onTap: onTap),
  );
}
