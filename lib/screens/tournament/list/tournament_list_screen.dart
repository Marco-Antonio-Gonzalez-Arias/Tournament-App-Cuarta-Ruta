import 'package:cuarta_ruta_app/core/utils/logger_util.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';
import 'package:cuarta_ruta_app/screens/tournament/list/widgets/tournament_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/services/tournament_storage_service.dart';
import 'package:cuarta_ruta_app/core/widgets/app_bar/app_bar_widget.dart';
import 'package:cuarta_ruta_app/models/tournament_model.dart';

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
      appBar: const AppBarWidget(title: "Torneos Guardados"),
      body: _buildFutureBody(),
    );
  }

  Widget _buildFutureBody() {
    return FutureBuilder<List<TournamentModel>>(
      future: TournamentStorageService().getAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final tournaments = snapshot.data ?? [];

        for (var tournament in tournaments) {
          logger.d(tournament);
        }

        if (tournaments.isEmpty) {
          return Center(
            child: Text(
              "No hay torneos guardados",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          );
        }

        return _buildTournamentList(context, tournaments);
      },
    );
  }

  Widget _buildTournamentList(
    BuildContext context,
    List<TournamentModel> tournaments,
  ) {
    final res = ResponsiveUtil.of(context);

    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: res.wp(10)),
      itemCount: tournaments.length,
      itemBuilder: (context, index) {
        final controller = _controllers.putIfAbsent(index, () => ExpansibleController());

        return TournamentTileWidget(
          tournament: tournaments[index],
          controller: controller,
          onExpansionChanged: (isExpanded) {
            if (isExpanded) {
              for (var key in _controllers.keys) {
                if (key != index) _controllers[key]?.collapse();
              }
            }
          },
        );
      },
      separatorBuilder: (context, index) =>
          Divider(thickness: res.hp(0.4), height: res.hp(3)),
    );
  }
}