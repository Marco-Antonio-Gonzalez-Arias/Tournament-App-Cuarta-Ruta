import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cuarta_ruta_app/core/providers/tournament_provider.dart';
import 'package:cuarta_ruta_app/core/widgets/app_bar/app_bar_widget.dart';
import 'package:cuarta_ruta_app/screens/tournament/creation/widgets/general_settings_widget.dart';
import 'package:cuarta_ruta_app/screens/tournament/creation/widgets/rounds_widget.dart';
import 'package:cuarta_ruta_app/screens/tournament/creation/widgets/sticky_create_button.dart';

class TournamentCreationScreen extends StatelessWidget {
  const TournamentCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TournamentProvider(),
      child: const Scaffold(
        appBar: AppBarWidget(title: "Configurar Torneo"),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [GeneralSettingsWidget(), Divider(), RoundsWidget()],
          ),
        ),
        bottomNavigationBar: StickyCreateButton(),
      ),
    );
  }
}