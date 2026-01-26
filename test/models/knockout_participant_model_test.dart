import 'package:flutter_test/flutter_test.dart';
import 'package:cuarta_ruta_app/models/impl/knockout_participant_model.dart';

void main() {
  group('KnockoutParticipantModel Tests', () {
    test('Constructor should initialize with UUID', () {
      final participant = KnockoutParticipantModel(name: 'Tester');

      expect(participant.id, isNotEmpty);
      expect(participant.name, 'Tester');
    });

    test('fromJson should create valid model', () {
      final json = {'id': '123', 'name': 'Tester'};

      final participant = KnockoutParticipantModel.fromJson(json);

      expect(participant.id, '123');
      expect(participant.name, 'Tester');
    });

    test('toJson should return correct map', () {
      final participant = KnockoutParticipantModel(id: '123', name: 'Tester');

      final json = participant.toJson();

      expect(json['id'], '123');
      expect(json['name'], 'Tester');
    });
  });
}
