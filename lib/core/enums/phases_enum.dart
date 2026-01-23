enum PhasesEnum { finalPhase, thirdPlace, semifinals, quarterFinals, roundOf16 }

extension PhaseDisplay on PhasesEnum {
  String get displayName {
    const names = {
      PhasesEnum.roundOf16: 'Octavos',
      PhasesEnum.quarterFinals: 'Cuartos',
      PhasesEnum.semifinals: 'Semifinales',
      PhasesEnum.thirdPlace: 'Tercer Puesto',
      PhasesEnum.finalPhase: 'Final',
    };
    return names[this] ?? name;
  }

  int get matchesCount {
    switch (this) {
      case PhasesEnum.roundOf16:
        return 8;
      case PhasesEnum.quarterFinals:
        return 4;
      case PhasesEnum.semifinals:
        return 2;
      case PhasesEnum.finalPhase:
        return 1;
      case PhasesEnum.thirdPlace:
        return 1;
    }
  }
}
