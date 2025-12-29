import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/utils/responsive.dart';
import 'package:cuarta_ruta_app/screens/tournament/widgets/page_indicator.dart';

class PageIndicatorsRow extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const PageIndicatorsRow({
    super.key,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalPages,
        (index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: responsive.wp(1)),
          child: PageIndicator(isActive: index == currentPage),
        ),
      ),
    );
  }
}