import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/config/dimensions/app_dimensions.dart';
import 'package:cuarta_ruta_app/core/config/routes/app_routes.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';
import 'package:cuarta_ruta_app/core/widgets/app_bar_widget/app_bar_widget.dart';
import 'package:cuarta_ruta_app/core/widgets/button_widget.dart';
import 'package:cuarta_ruta_app/core/widgets/logo_image_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Inicio",
        height: AppDimensions.appBarHeight(context.res),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: context.res.wp(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildMenuContent(context),
      ),
    );
  }

  List<Widget> _buildMenuContent(BuildContext context) {
    return [
      _buildLogo(context),
      SizedBox(height: context.res.hp(10)),
      ButtonWidget(
        label: 'Torneo',
        onPressed: () => _navigateToTournament(context),
      ),
      SizedBox(height: context.res.hp(3)),
      ButtonWidget(label: 'Libre', onPressed: () {}),
      SizedBox(height: context.res.hp(3)),
      ButtonWidget(label: 'Visuales', onPressed: () {}),
    ];
  }

  Widget _buildLogo(BuildContext context) => LogoImageWidget(
    height: context.res.hp(15),
    lightAsset: 'assets/icon/icon_light.png',
    darkAsset: 'assets/icon/icon_black.png',
  );

  void _navigateToTournament(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.tournamentMenu);
  }
}
