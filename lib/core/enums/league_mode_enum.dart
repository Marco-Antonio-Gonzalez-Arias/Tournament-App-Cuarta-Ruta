enum LeagueModeEnum { singleNoExtra, doubleWithExtra }

extension LeagueModeDisplay on LeagueModeEnum {
  String get displayName {
    switch (this) {
      case LeagueModeEnum.singleNoExtra:
        return '1 batalla por participante, sin Extra Player';
      case LeagueModeEnum.doubleWithExtra:
        return '2 batallas por participante, con Extra Player';
    }
  }

  int get battles => this == LeagueModeEnum.singleNoExtra ? 1 : 2;
  bool get extraPlayer => this == LeagueModeEnum.doubleWithExtra;
}
