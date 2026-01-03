enum Phases { faseFinal, tercerPuesto, semifinales, cuartos, octavos }

extension PhaseDisplay on Phases {
  String get displayName {
    const names = {
      Phases.octavos: 'Octavos',
      Phases.cuartos: 'Cuartos',
      Phases.semifinales: 'Semifinales',
      Phases.tercerPuesto: 'Tercer Puesto',
      Phases.faseFinal: 'Final',
    };
    return names[this] ?? name;
  }
}
