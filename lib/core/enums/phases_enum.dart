enum PhasesEnum { faseFinal, tercerPuesto, semifinales, cuartos, octavos }

extension PhaseDisplay on PhasesEnum {
  String get displayName {
    const names = {
      PhasesEnum.octavos: 'Octavos',
      PhasesEnum.cuartos: 'Cuartos',
      PhasesEnum.semifinales: 'Semifinales',
      PhasesEnum.tercerPuesto: 'Tercer Puesto',
      PhasesEnum.faseFinal: 'Final',
    };
    return names[this] ?? name;
  }
}
