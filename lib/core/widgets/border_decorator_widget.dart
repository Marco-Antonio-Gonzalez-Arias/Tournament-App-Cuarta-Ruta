import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';
import 'package:cuarta_ruta_app/core/widgets/gold_card_decorator.dart';

class BorderDecoratorWidget extends StatelessWidget {
  final Widget child;

  const BorderDecoratorWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Stack(
          children: [_buildMainContent(context), _buildFrame(context)],
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) => Padding(
    padding: EdgeInsets.all(context.res.dp(1)),
    child: ClipRect(child: child),
  );

  Widget _buildFrame(BuildContext context) => IgnorePointer(
    child: Padding(
      padding: EdgeInsets.all(context.res.dp(1)),
      child: GoldCardDecorator(borderRadius: 0, child: const SizedBox.expand()),
    ),
  );
}
