import 'package:cuarta_ruta_app/core/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/helpers/phase_generator.dart';
import 'package:cuarta_ruta_app/core/widgets/counter_selector.dart';
import 'package:cuarta_ruta_app/core/utils/responsive.dart';
import 'package:cuarta_ruta_app/models/tournament_model.dart';
import 'package:cuarta_ruta_app/core/services/tournament_storage_service.dart';
import 'package:cuarta_ruta_app/screens/tournament/widgets/page_indicators_row.dart';

class RoundsScreen extends StatefulWidget {
  final Phases startPhase;
  final bool hasThirdPlace;
  final bool hasReplica;

  const RoundsScreen({
    super.key,
    required this.startPhase,
    required this.hasThirdPlace,
    required this.hasReplica,
  });

  @override
  State<RoundsScreen> createState() => _RoundsScreenState();
}

class _RoundsScreenState extends State<RoundsScreen> {
  final Map<Phases, int> _roundsConfig = {};
  final _storageService = TournamentStorageService();

  List<Phases> get _phases =>
      PhaseGenerator.generate(widget.startPhase, widget.hasThirdPlace);

  @override
  void initState() {
    super.initState();
    _initializeRoundsConfig();
  }

  void _initializeRoundsConfig() {
    for (var phase in _phases) {
      _roundsConfig[phase] = 1;
    }
  }

  void _updateRounds(Phases phase, int delta) {
    setState(() => _roundsConfig[phase] = _roundsConfig[phase]! + delta);
  }

  Future<void> _saveTournament() async {
    final tournament = TournamentModel(
      startPhase: widget.startPhase,
      hasThirdPlace: widget.hasThirdPlace,
      hasReplica: widget.hasReplica,
      roundsConfig: _roundsConfig,
    );
    await _storageService.create(tournament);
    if (mounted) Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final res = Responsive.of(context);
    final theme = Theme.of(context);

    return Container(
      color: theme.scaffoldBackgroundColor,
      padding: EdgeInsets.symmetric(
        horizontal: res.wp(10),
        vertical: res.hp(5),
      ),
      child: Column(
        children: [
          _buildHeader(theme),
          SizedBox(height: res.hp(5)),
          _buildRoundsList(res, theme),
          SizedBox(height: res.hp(3)),
          Button(
            label: 'Crear',
            onPressed: _saveTournament,
            textStyle: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: res.hp(2)),
          const PageIndicatorsRow(currentPage: 1, totalPages: 2),
        ],
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Text(
      'Rondas',
      style: theme.textTheme.titleSmall?.copyWith(
        color: theme.colorScheme.onSurface,
      ),
    );
  }

  Widget _buildRoundsList(Responsive res, ThemeData theme) {
    return Expanded(
      child: ListView.separated(
        itemCount: _phases.length,
        separatorBuilder: (_, __) => SizedBox(height: res.hp(2)),
        itemBuilder: (context, index) => _buildRoundItem(_phases[index], theme),
      ),
    );
  }

  Widget _buildRoundItem(Phases phase, ThemeData theme) {
    return CounterSelector(
      label: phase.name,
      count: _roundsConfig[phase]!,
      onIncrement: () => _updateRounds(phase, 1),
      onDecrement: () => _updateRounds(phase, -1),
      min: 1,
      max: 5,
      textStyle: theme.textTheme.bodySmall?.copyWith(
        color: theme.colorScheme.onSurface,
      ),
    );
  }
}