import 'package:flutter_test/flutter_test.dart';
import 'package:cuarta_ruta_app/core/enums/phases_enum.dart';

void main() {
  group('PhasesEnum Extension Tests', () {
    test('displayName should return correct Spanish names', () {
      expect(PhasesEnum.roundOf16.displayName, 'Octavos');
      expect(PhasesEnum.quarterFinals.displayName, 'Cuartos');
      expect(PhasesEnum.semifinals.displayName, 'Semifinales');
      expect(PhasesEnum.thirdPlace.displayName, 'Tercer Puesto');
      expect(PhasesEnum.finalPhase.displayName, 'Final');
    });
  });
}
