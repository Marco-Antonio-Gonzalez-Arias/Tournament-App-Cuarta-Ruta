import 'package:cuarta_ruta_app/core/services/app_preferences_base.dart';
import 'package:cuarta_ruta_app/core/services/tournament_storage_base.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cuarta_ruta_app/core/config/dimensions/app_dimensions.dart';
import 'package:cuarta_ruta_app/core/providers/tournament_list_provider.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';
import 'package:cuarta_ruta_app/core/enums/tournament_sort_option_enum.dart';
import 'package:cuarta_ruta_app/core/widgets/popup_menu_widget.dart';
import 'package:cuarta_ruta_app/core/widgets/app_bar_widget/app_bar_widget.dart';
import 'package:cuarta_ruta_app/core/widgets/gold_card_decorator.dart';
import 'package:cuarta_ruta_app/models/tournament_base.dart'; // Cambio aquí
import 'package:cuarta_ruta_app/screens/tournament/list/widgets/tournament_tile_widget.dart';
import 'package:cuarta_ruta_app/screens/tournament/list/widgets/empty_tournaments_widget.dart';

class TournamentListScreen extends StatefulWidget {
  const TournamentListScreen({super.key});

  @override
  State<TournamentListScreen> createState() => _TournamentListScreenState();
}

class _TournamentListScreenState extends State<TournamentListScreen> {
  final Map<String, ExpansibleController> _controllers = {};

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    _controllers.clear();
    super.dispose();
  }

  void _onSortChanged(
    TournamentListProvider provider,
    TournamentSortOptionEnum option,
  ) {
    for (var controller in _controllers.values) {
      controller.collapse();
    }
    provider.setSortOption(option);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TournamentListProvider(
        context.read<TournamentStorageBase>(),
        context.read<AppPreferencesBase>(),
      )..loadTournaments(),
      builder: (context, child) {
        final provider = context.watch<TournamentListProvider>();

        return Scaffold(
          appBar: AppBarWidget(
            title: "Torneos Guardados",
            height: AppDimensions.appBarHeight(context.res),
            actions: [_buildSortMenu(provider)],
          ),
          body: provider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : provider.tournaments.isEmpty
              ? const EmptyTournamentsWidget()
              : _buildTournamentList(provider.tournaments),
        );
      },
    );
  }

  Widget _buildSortMenu(TournamentListProvider provider) {
    return PopupMenuWidget<TournamentSortOptionEnum>(
      icon: Icon(Icons.sort, size: context.res.dp(3)),
      initialValue: provider.sortOption,
      onSelected: (option) => _onSortChanged(provider, option),
      constraints: BoxConstraints(minWidth: context.res.dp(20)),
      textStyle: Theme.of(
        context,
      ).textTheme.labelSmall?.copyWith(fontSize: context.res.dp(1.5)),
      items: const [
        PopupMenuItem(
          value: TournamentSortOptionEnum.nameAsc,
          child: Text("A-Z"),
        ),
        PopupMenuItem(
          value: TournamentSortOptionEnum.nameDesc,
          child: Text("Z-A"),
        ),
        PopupMenuItem(
          value: TournamentSortOptionEnum.dateNewest,
          child: Text("Más reciente"),
        ),
        PopupMenuItem(
          value: TournamentSortOptionEnum.dateOldest,
          child: Text("Más antiguo"),
        ),
      ],
    );
  }

  Widget _buildTournamentList(List<TournamentBase> tournaments) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(
        horizontal: context.res.wp(7),
        vertical: context.res.hp(2),
      ),
      itemCount: tournaments.length,
      separatorBuilder: (_, __) => SizedBox(height: context.res.hp(1)),
      itemBuilder: (context, index) => _buildTournamentItem(tournaments[index]),
    );
  }

  Widget _buildTournamentItem(TournamentBase tournament) {
    return GoldCardDecorator(
      child: TournamentTileWidget(
        tournament: tournament,
        controller: _controllers.putIfAbsent(
          tournament.id,
          () => ExpansibleController(),
        ),
        onExpansionChanged: (isExpanded) =>
            _handleExpansion(tournament.id, isExpanded),
      ),
    );
  }

  void _handleExpansion(String currentId, bool isExpanded) {
    if (!isExpanded) return;
    for (var entry in _controllers.entries) {
      if (entry.key != currentId) entry.value.collapse();
    }
  }
}
