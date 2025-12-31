import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';
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
    final res = ResponsiveUtil.of(context);
    
    return ChangeNotifierProvider(
      create: (_) => TournamentProvider(),
      child: Scaffold(
        appBar: AppBarWidget(title: "Crear Torneo"),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              const GeneralSettingsWidget(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: res.wp(10)),
                child: const Divider(),
              ),
              const RoundsWidget()
              ],
          ),
        ),
        bottomNavigationBar: StickyCreateButton(),
      ),
    );
  }
}