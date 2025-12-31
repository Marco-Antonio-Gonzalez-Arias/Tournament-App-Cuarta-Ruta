import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';
import 'package:cuarta_ruta_app/core/widgets/app_bar/app_bar_widget.dart';
import 'package:cuarta_ruta_app/core/widgets/menu_option_widget.dart';
import 'package:cuarta_ruta_app/screens/tournament/list/tournament_list_screen.dart';
import 'package:cuarta_ruta_app/screens/tournament/creation/tournament_creation_screen.dart';

class TournamentMenuScreen extends StatelessWidget {
  const TournamentMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Torneo"),
      body: Padding(
        padding: EdgeInsets.only(bottom: ResponsiveUtil.of(context).dp(1.3)),
        child: Column(
          children: [
            MenuOptionWidget(
              imagePath: 'assets/images/guardados.png',
              label: 'Guardados',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TournamentListScreen()),
              ),
            ),
            MenuOptionWidget(
              imagePath: 'assets/images/crear.png',
              label: 'Crear',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const TournamentCreationScreen(),
                ),
              ),
            ),
            MenuOptionWidget(
              imagePath: 'assets/images/escanear.png',
              label: 'Escanear',
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
