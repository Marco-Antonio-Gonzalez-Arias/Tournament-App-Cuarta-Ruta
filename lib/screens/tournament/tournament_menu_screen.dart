import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/config/routes/app_routes.dart';
import 'package:cuarta_ruta_app/core/config/dimensions/app_dimensions.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';
import 'package:cuarta_ruta_app/core/widgets/app_bar_widget/app_bar_widget.dart';
import 'package:cuarta_ruta_app/core/widgets/menu_option_widget.dart';

class TournamentMenuScreen extends StatelessWidget {
  const TournamentMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Torneo",
        height: AppDimensions.appBarHeight(context.res),
      ),
      body: _buildOptionsList(context),
    );
  }

  Widget _buildOptionsList(BuildContext context) {
    return Column(
      children: [
        _buildOption(
          context,
          image: 'assets/images/guardados.png',
          label: 'Guardados',
          routeName: AppRoutes.tournamentList,
        ),
        _buildOption(
          context,
          image: 'assets/images/crear.png',
          label: 'Crear',
          routeName: AppRoutes.tournamentCreation,
        ),
        _buildScanOption(context),
      ],
    );
  }

  Widget _buildOption(
    BuildContext context, {
    required String image,
    required String label,
    required String routeName,
  }) => Expanded(
    child: MenuOptionWidget(
      imagePath: image,
      label: label,
      onTap: () => _navigateTo(context, routeName),
    ),
  );

  Widget _buildScanOption(BuildContext context) => Expanded(
    child: MenuOptionWidget(
      imagePath: 'assets/images/escanear.png',
      label: 'Escanear',
      onTap: () => Navigator.pop(context),
    ),
  );

  void _navigateTo(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }
}
