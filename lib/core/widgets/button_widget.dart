import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';
import 'package:cuarta_ruta_app/core/widgets/gold_card_decorator.dart';

class ButtonWidget extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final TextStyle? textStyle;

  const ButtonWidget({
    super.key,
    required this.label,
    required this.onPressed,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return GoldCardDecorator(
      child: SizedBox(
        width: double.infinity,
        height: context.res.hp(9),
        child: _buildButton(context),
      ),
    );
  }

  Widget _buildButton(BuildContext context) => OutlinedButton(
    onPressed: onPressed,
    style: OutlinedButton.styleFrom(
      side: BorderSide.none,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    ),
    child: Text(
      label,
      style: textStyle ?? Theme.of(context).textTheme.titleLarge,
    ),
  );
}
