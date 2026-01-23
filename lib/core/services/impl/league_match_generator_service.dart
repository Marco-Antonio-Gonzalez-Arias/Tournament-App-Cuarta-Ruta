import 'package:cuarta_ruta_app/core/services/league_match_generator_service_base.dart';
import 'package:cuarta_ruta_app/models/impl/match_model.dart';

class LeagueMatchGeneratorService implements LeagueMatchGeneratorServiceBase {
  static const String extraPlayerPlaceholder = 'EXTRA_PLAYER_PLACEHOLDER';

  @override
  Map<int, List<MatchModel>> generate({
    required List<String> participantIds,
    required int battlesPerParticipant,
  }) {
    final List<MatchModel> allMatches = _generateUniquePairings(participantIds);

    if (battlesPerParticipant == 2) {
      allMatches.addAll(_generateExtraPlayerMatches(participantIds));
    }

    return _groupMatchesIntoMatchdays(
      allMatches: allMatches,
      numParticipants: participantIds.length,
      battlesPerParticipant: battlesPerParticipant,
    );
  }

  List<MatchModel> _generateUniquePairings(List<String> participantIds) {
    final List<String> pool = List.from(participantIds);
    final int numParticipants = pool.length;
    final int numRounds = numParticipants - 1;
    final int matchesPerRound = numParticipants ~/ 2;
    final List<MatchModel> pairings = [];

    for (int round = 0; round < numRounds; round++) {
      for (int i = 0; i < matchesPerRound; i++) {
        pairings.add(
          MatchModel(
            participantAId: pool[i],
            participantBId: pool[numParticipants - 1 - i],
          ),
        );
      }
      pool.insert(1, pool.removeLast());
    }
    return pairings;
  }

  List<MatchModel> _generateExtraPlayerMatches(List<String> participantIds) {
    return participantIds
        .map(
          (id) => MatchModel(
            participantAId: id,
            participantBId: extraPlayerPlaceholder,
          ),
        )
        .toList();
  }

  Map<int, List<MatchModel>> _groupMatchesIntoMatchdays({
    required List<MatchModel> allMatches,
    required int numParticipants,
    required int battlesPerParticipant,
  }) {
    final Map<int, List<MatchModel>> schedule = {};

    final int matchesPerMatchday = battlesPerParticipant == 2
        ? (numParticipants + 1)
        : numParticipants ~/ 2;

    int currentMatchIndex = 0;
    int matchdayIndex = 1;

    while (currentMatchIndex < allMatches.length) {
      int end = currentMatchIndex + matchesPerMatchday;
      if (end > allMatches.length) end = allMatches.length;

      schedule[matchdayIndex] = allMatches.sublist(currentMatchIndex, end);
      currentMatchIndex = end;
      matchdayIndex++;
    }
    return schedule;
  }
}
