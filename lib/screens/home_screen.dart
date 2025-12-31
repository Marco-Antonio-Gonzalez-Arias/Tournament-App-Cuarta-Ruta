import 'package:cuarta_ruta_app/core/widgets/app_bar/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';
import 'package:cuarta_ruta_app/core/widgets/button_widget.dart';
import 'package:cuarta_ruta_app/core/widgets/logo_image_widget.dart';
import 'package:cuarta_ruta_app/screens/tournament/tournament_menu_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil.of(context);

    return Scaffold(
      appBar: const AppBarWidget(title: "Inicio"),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: responsive.wp(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLogo(responsive),
            SizedBox(height: responsive.hp(10)),
            ButtonWidget(label: 'Torneo', onPressed: () => _toTournament(context)),
            SizedBox(height: responsive.hp(3)),
            ButtonWidget(label: 'Libre', onPressed: () {}),
            SizedBox(height: responsive.hp(3)),
            ButtonWidget(label: 'Visuales', onPressed: () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo(ResponsiveUtil responsive) {
    return LogoImageWidget(height: responsive.hp(15));
  }

  void _toTournament(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TournamentMenuScreen()),
    );
  }
}
