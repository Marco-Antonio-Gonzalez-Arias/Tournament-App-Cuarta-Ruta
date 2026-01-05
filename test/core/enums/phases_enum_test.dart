import 'package:flutter_test/flutter_test.dart';
import 'package:cuarta_ruta_app/core/enums/phases_enum.dart';

void main() {
  group('PhasesEnum Extension Tests', () {
    test('displayName should return correct Spanish names', () {
      expect(PhasesEnum.octavos.displayName, 'Octavos');
      expect(PhasesEnum.cuartos.displayName, 'Cuartos');
      expect(PhasesEnum.semifinales.displayName, 'Semifinales');
      expect(PhasesEnum.tercerPuesto.displayName, 'Tercer Puesto');
      expect(PhasesEnum.faseFinal.displayName, 'Final');
    });
  });
}
