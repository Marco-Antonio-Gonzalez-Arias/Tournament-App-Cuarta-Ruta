enum TournamentTypeEnum { knockout, league }

extension TournamentTypeDisplay on TournamentTypeEnum {
  String get displayName {
    switch (this) {
      case TournamentTypeEnum.knockout:
        return 'Eliminatorias';
      case TournamentTypeEnum.league:
        return 'Liga';
    }
  }
}
