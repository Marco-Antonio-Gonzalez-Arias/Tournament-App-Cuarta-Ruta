import 'package:flutter_test/flutter_test.dart';
import 'package:cuarta_ruta_app/models/impl/tournament_model.dart';
import 'package:cuarta_ruta_app/core/enums/phases_enum.dart';

void main() {
  group('TournamentModel Tests', () {
    final Map<PhasesEnum, int> mockConfig = {
      PhasesEnum.quarterFinals: 4,
      PhasesEnum.semifinals: 2,
    };

    test('Constructor should initialize with UUID and current Date', () {
      final model = TournamentModel(
        name: 'Copa Pistón',
        startPhase: PhasesEnum.quarterFinals,
        hasThirdPlace: true,
        hasReplica: false,
        roundsConfig: mockConfig,
      );

      expect(model.id, isNotEmpty);
      expect(model.name, 'Copa Pistón');
      expect(model.createdAt, isA<DateTime>());
      expect(model.startPhase, PhasesEnum.quarterFinals);
    });

    test('fromJson should create a valid model with correct Enums', () {
      final json = {
        'id': 'uuid-123',
        'name': 'Torneo Local',
        'startPhase': 'cuartos',
        'hasThirdPlace': true,
        'hasReplica': false,
        'roundsConfig': {'cuartos': 4, 'semifinales': 2},
        'createdAt': '2023-10-27T10:00:00.000',
      };

      final model = TournamentModel.fromJson(json);

      expect(model.id, 'uuid-123');
      expect(model.startPhase, PhasesEnum.quarterFinals);
      expect(model.roundsConfig.containsKey(PhasesEnum.semifinals), true);
      expect(model.roundsConfig[PhasesEnum.quarterFinals], 4);
    });

    test('toJson should return strings matching Enum names', () {
      final model = TournamentModel(
        name: 'Master Cup',
        startPhase: PhasesEnum.finalPhase,
        hasThirdPlace: false,
        hasReplica: true,
        roundsConfig: {PhasesEnum.finalPhase: 1},
      );

      final json = model.toJson();

      expect(json['startPhase'], 'faseFinal');
      expect(json['roundsConfig']['faseFinal'], 1);
      expect(json['hasReplica'], true);
    });

    test('copyWith should maintain immutability of non-specified fields', () {
      final model = TournamentModel(
        name: 'Original',
        startPhase: PhasesEnum.roundOf16,
        hasThirdPlace: false,
        hasReplica: false,
        roundsConfig: {},
      );

      final updated = model.copyWith(name: 'Nuevo Nombre');

      expect(updated.name, 'Nuevo Nombre');
      expect(updated.id, model.id);
      expect(updated.startPhase, PhasesEnum.roundOf16);
      expect(updated.createdAt, model.createdAt);
    });
  });
}
