import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/helpers/phase_generator.dart';
import 'package:cuarta_ruta_app/screens/tournament/rounds/widgets/finish_button.dart';
import 'package:cuarta_ruta_app/screens/tournament/rounds/widgets/round_selector.dart';
import 'package:cuarta_ruta_app/core/utils/responsive.dart';
import 'package:cuarta_ruta_app/core/config/theme/app_colors.dart';
import 'package:cuarta_ruta_app/models/tournament_model.dart';
import 'package:cuarta_ruta_app/core/services/tournament_storage_service.dart';
import 'package:cuarta_ruta_app/screens/tournament/widgets/page_indicators_row.dart';

class RoundsScreen extends StatefulWidget {
  final StartingPhase startPhase;
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
  final Map<String, int> _roundsConfig = {};
  final _storageService = TournamentStorageService();

  List<String> get _phases =>
      PhaseGenerator.generatePhases(widget.startPhase, widget.hasThirdPlace);

  @override
  void initState() {
    super.initState();
    _initializeRoundsConfig();
  }

  void _initializeRoundsConfig() {
    for (var phase in _phases) {
      _roundsConfig[phase] = 3;
    }
  }

  Future<void> _saveTournament() async {
    final tournament = TournamentModel(
      startPhase: widget.startPhase,
      hasThirdPlace: widget.hasThirdPlace,
      hasReplica: widget.hasReplica,
      roundsConfig: _roundsConfig,
    );

    await _storageService.saveTournament(tournament);

    if (mounted) {
      Navigator.popUntil(context, (route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return Container(
      color: AppColors.backgroundBlack,
      padding: EdgeInsets.symmetric(
        horizontal: responsive.wp(10),
        vertical: responsive.hp(5),
      ),
      child: Column(
        children: [
          Text(
            'RONDAS',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: AppColors.primaryWhite,
                ),
          ),
          SizedBox(height: responsive.hp(5)),
          Expanded(
            child: ListView.separated(
              itemCount: _phases.length,
              separatorBuilder: (_, __) => SizedBox(height: responsive.hp(2)),
              itemBuilder: (context, index) {
                final phase = _phases[index];
                return RoundSelector(
                  phase: phase,
                  rounds: _roundsConfig[phase]!,
                );
              },
            ),
          ),
          SizedBox(height: responsive.hp(3)),
          FinishButton(onPressed: _saveTournament),
          SizedBox(height: responsive.hp(2)),
          const PageIndicatorsRow(currentPage: 1, totalPages: 2),
        ],
      ),
    );
  }
}