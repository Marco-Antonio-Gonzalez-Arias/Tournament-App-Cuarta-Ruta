import 'package:cuarta_ruta_app/core/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/utils/responsive.dart';
import 'package:cuarta_ruta_app/core/widgets/button.dart';
import 'package:cuarta_ruta_app/core/widgets/logo_image.dart';
import 'package:cuarta_ruta_app/screens/tournament/tournament.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return Scaffold(
      appBar: const MyAppBar(title: "Inicio"),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: responsive.wp(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLogo(responsive),
            SizedBox(height: responsive.hp(10)),
            Button(label: 'Torneo', onPressed: () => _toTournament(context)),
            SizedBox(height: responsive.hp(3)),
            Button(label: 'Libre', onPressed: () {}),
            SizedBox(height: responsive.hp(3)),
            Button(label: 'Visuales', onPressed: () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo(Responsive responsive) {
    return LogoImage(height: responsive.hp(15));
  }

  void _toTournament(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Tournament()),
    );
  }
}
