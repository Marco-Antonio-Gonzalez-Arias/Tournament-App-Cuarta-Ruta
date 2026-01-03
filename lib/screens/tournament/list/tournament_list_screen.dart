import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cuarta_ruta_app/core/config/dimensions/app_dimensions.dart';
import 'package:cuarta_ruta_app/core/services/tournament_storage_base.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';
import 'package:cuarta_ruta_app/core/widgets/app_bar_widget/app_bar_widget.dart';
import 'package:cuarta_ruta_app/core/widgets/gold_card_decorator.dart';
import 'package:cuarta_ruta_app/models/tournament_model.dart';
import 'package:cuarta_ruta_app/screens/tournament/list/widgets/tournament_tile_widget.dart';
import 'package:cuarta_ruta_app/screens/tournament/list/widgets/empty_tournaments_widget.dart';

class TournamentListScreen extends StatefulWidget {
  const TournamentListScreen({super.key});

  @override
  State<TournamentListScreen> createState() => _TournamentListScreenState();
}

class _TournamentListScreenState extends State<TournamentListScreen> {
  final Map<int, ExpansibleController> _controllers = {};

  @override
  void dispose() {
    _controllers.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Torneos Guardados",
        height: AppDimensions.appBarHeight(context.res),
      ),
      body: _buildFutureBody(),
    );
  }

  Widget _buildFutureBody() {
    final storageService = context.read<TournamentStorageBase>();

    return FutureBuilder<List<TournamentModel>>(
      future: storageService.getAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final tournaments = snapshot.data ?? [];
        if (tournaments.isEmpty) return const EmptyTournamentsWidget();

        return _buildTournamentList(tournaments);
      },
    );
  }

  Widget _buildTournamentList(List<TournamentModel> tournaments) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(
        horizontal: context.res.wp(7),
        vertical: context.res.hp(2),
      ),
      itemCount: tournaments.length,
      itemBuilder: (context, index) =>
          _buildTournamentTile(index, tournaments[index]),
      separatorBuilder: (context, index) => SizedBox(height: context.res.hp(1)),
    );
  }

  Widget _buildTournamentTile(int index, TournamentModel tournament) {
    return GoldCardDecorator(
      child: TournamentTileWidget(
        tournament: tournament,
        controller: _getController(index),
        onExpansionChanged: (isExpanded) => _handleExpansion(index, isExpanded),
      ),
    );
  }

  ExpansibleController _getController(int index) {
    return _controllers.putIfAbsent(index, () => ExpansibleController());
  }

  void _handleExpansion(int currentIndex, bool isExpanded) {
    if (!isExpanded) return;
    for (var controller in _controllers.values) {
      if (controller != _controllers[currentIndex]) controller.collapse();
    }
  }
}
