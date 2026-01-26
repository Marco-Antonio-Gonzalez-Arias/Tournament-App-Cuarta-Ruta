import 'package:flutter_test/flutter_test.dart';
import 'package:cuarta_ruta_app/core/services/impl/league_participant_service.dart';
import 'package:cuarta_ruta_app/models/impl/league_participant_model.dart';

void main() {
  late LeagueParticipantService service;
  late LeagueParticipantModel initialParticipant;

  setUp(() {
    service = LeagueParticipantService();
    initialParticipant = LeagueParticipantModel(
      id: 'p1',
      name: 'Batallador',
      totalPoints: 10,
      ptb: 50,
      directWins: 1,
    );
  });

  group('LeagueParticipantService Tests', () {
    test('updateStats should correctly accumulate points and ptb', () {
      final result = service.updateStats(
        participant: initialParticipant,
        points: 3,
        ptb: 20,
        isWin: true,
        isReplica: false,
      );

      expect(result.totalPoints, 13);
      expect(result.ptb, 70);
    });

    test(
      'updateStats should increment directWins when winning without replica',
      () {
        final result = service.updateStats(
          participant: initialParticipant,
          points: 3,
          ptb: 5,
          isWin: true,
          isReplica: false,
        );

        expect(result.directWins, 2);
        expect(result.replicaWins, 0);
      },
    );

    test(
      'updateStats should increment replicaWins when winning with replica',
      () {
        final result = service.updateStats(
          participant: initialParticipant,
          points: 2,
          ptb: 5,
          isWin: true,
          isReplica: true,
        );

        expect(result.replicaWins, 1);
        expect(result.directWins, 1);
      },
    );

    test(
      'updateStats should increment directLosses when losing without replica',
      () {
        final result = service.updateStats(
          participant: initialParticipant,
          points: 0,
          ptb: 2,
          isWin: false,
          isReplica: false,
        );

        expect(result.directLosses, 1);
      },
    );

    test(
      'updateStats should increment replicaLosses when losing with replica',
      () {
        final result = service.updateStats(
          participant: initialParticipant,
          points: 1,
          ptb: 4,
          isWin: false,
          isReplica: true,
        );

        expect(result.replicaLosses, 1);
      },
    );
  });
}
