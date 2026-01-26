import 'package:flutter_test/flutter_test.dart';
import 'package:cuarta_ruta_app/models/impl/knockout_tournament_model.dart';
import 'package:cuarta_ruta_app/core/enums/phases_enum.dart';

void main() {
  group('KnockoutTournamentModel Tests', () {
    final Map<PhasesEnum, int> mockConfig = {
      PhasesEnum.quarterFinals: 4,
      PhasesEnum.semifinals: 2,
    };

    test('Constructor should initialize with UUID and current Date', () {
      final model = KnockoutTournamentModel(
        name: 'Copa Pistón',
        pointsDifference: 2,
        replicaCount: 1,
        startPhase: PhasesEnum.quarterFinals,
        hasThirdPlace: true,
        hasWildcard: false,
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
        'pointsDifference': 2,
        'replicaCount': 1,
        'startPhase': 'quarterFinals',
        'hasThirdPlace': true,
        'hasWildcard': false,
        'roundsConfig': {'quarterFinals': 4, 'semifinals': 2},
        'createdAt': '2023-10-27T10:00:00.000',
      };

      final model = KnockoutTournamentModel.fromJson(json);

      expect(model.id, 'uuid-123');
      expect(model.startPhase, PhasesEnum.quarterFinals);
      expect(model.roundsConfig.containsKey(PhasesEnum.semifinals), true);
      expect(model.roundsConfig[PhasesEnum.quarterFinals], 4);
    });

    test('toJson should return strings matching Enum names', () {
      final model = KnockoutTournamentModel(
        name: 'Master Cup',
        pointsDifference: 2,
        replicaCount: 1,
        startPhase: PhasesEnum.finalPhase,
        hasThirdPlace: false,
        hasWildcard: true,
        roundsConfig: {PhasesEnum.finalPhase: 1},
      );

      final json = model.toJson();

      expect(json['startPhase'], 'finalPhase');
      expect(json['roundsConfig']['finalPhase'], 1);
      expect(json['hasWildcard'], true);
      expect(json['type'], 'knockout');
    });

    test('copyWith should maintain immutability of non-specified fields', () {
      final model = KnockoutTournamentModel(
        name: 'Original',
        pointsDifference: 2,
        replicaCount: 1,
        startPhase: PhasesEnum.roundOf16,
        hasThirdPlace: false,
        hasWildcard: false,
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
