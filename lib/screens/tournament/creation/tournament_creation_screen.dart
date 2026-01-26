import 'package:cuarta_ruta_app/core/enums/tournament_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cuarta_ruta_app/core/config/dimensions/app_dimensions.dart';
import 'package:cuarta_ruta_app/core/providers/tournament_provider.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';
import 'package:cuarta_ruta_app/core/widgets/app_bar_widget/app_bar_widget.dart';
import 'package:cuarta_ruta_app/screens/tournament/creation/widgets/general_settings_widget.dart';
import 'package:cuarta_ruta_app/screens/tournament/creation/widgets/rounds_widget.dart';
import 'package:cuarta_ruta_app/screens/tournament/creation/widgets/sticky_create_button_widget.dart';

class TournamentCreationScreen extends StatelessWidget {
  const TournamentCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TournamentProvider(),
      child: Scaffold(
        appBar: AppBarWidget(
          title: "Crear Torneo",
          height: AppDimensions.appBarHeight(context.res),
        ),
        body: _buildBody(context),
        bottomNavigationBar: const StickyCreateButtonWidget(),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final type = context.select<TournamentProvider, TournamentTypeEnum>(
      (p) => p.type,
    );

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const GeneralSettingsWidget(),
          if (type == TournamentTypeEnum.knockout) ...[
            _buildDivider(context),
            const RoundsWidget(),
          ],
        ],
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.res.wp(6)),
      child: const Divider(),
    );
  }
}
