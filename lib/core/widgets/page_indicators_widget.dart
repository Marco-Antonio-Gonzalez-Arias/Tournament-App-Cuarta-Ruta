import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';

class PageIndicators extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const PageIndicators({
    super.key,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalPages,
        (index) => _PageDot(isActive: index == currentPage),
      ),
    );
  }
}

class _PageDot extends StatelessWidget {
  final bool isActive;

  const _PageDot({required this.isActive});

  @override
  Widget build(BuildContext context) {
    final res = ResponsiveUtil.of(context);
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: res.wp(1)),
      child: Container(
        width: res.dp(1),
        height: res.dp(1),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive
              ? theme.colorScheme.primary
              : theme.colorScheme.primary.withAlpha(30),
        ),
      ),
    );
  }
}