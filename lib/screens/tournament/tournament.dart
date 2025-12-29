import 'package:cuarta_ruta_app/core/utils/responsive.dart';
import 'package:cuarta_ruta_app/screens/tournament/tournament_creation_flow/tournament_creation_flow.dart';
import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/widgets/app_bar/app_bar.dart';
import 'package:cuarta_ruta_app/screens/tournament/widgets/tournament_option.dart';

class Tournament extends StatelessWidget {
  const Tournament({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Torneo"),
      body: Padding(
        padding: EdgeInsets.only(bottom: Responsive.of(context).dp(1.3)),
        child: Column(
          children: [
            TournamentOption(
              imagePath: 'assets/images/cargar.png',
              label: 'Cargar',
              onTap: () => _onCargar(context),
            ),
            TournamentOption(
              imagePath: 'assets/images/crear.png',
              label: 'Crear',
              onTap: () => _onCrear(context),
            ),
            TournamentOption(
              imagePath: 'assets/images/escanear.png',
              label: 'escanear',
              onTap: () => _onEscanear(context),
            ),
          ],
        ),
      ),
    );
  }

  static void _onCargar(BuildContext context) {
    Navigator.pop(context);
  }

  static void _onCrear(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const TournamentCreationFlow()),
  );
}

  static void _onEscanear(BuildContext context) {
    Navigator.pop(context);
  }
}
