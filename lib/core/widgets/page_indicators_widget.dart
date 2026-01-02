import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/widgets/page_dot_widget.dart';

class PageIndicatorsWidget extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const PageIndicatorsWidget({
    super.key,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _buildIndicators(),
    );
  }

  List<Widget> _buildIndicators() {
    return List.generate(
      totalPages,
      (index) => PageDotWidget(isActive: index == currentPage),
    );
  }
}
