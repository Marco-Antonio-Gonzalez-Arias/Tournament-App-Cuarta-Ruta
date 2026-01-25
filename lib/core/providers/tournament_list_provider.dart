import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:cuarta_ruta_app/core/services/app_preferences_base.dart';
import 'package:cuarta_ruta_app/core/services/tournament_storage_base.dart';
import 'package:cuarta_ruta_app/core/enums/tournament_sort_option_enum.dart';
import 'package:cuarta_ruta_app/models/tournament_base.dart';

class TournamentListProvider extends ChangeNotifier {
  final TournamentStorageBase _storage;
  final AppPreferencesBase _prefs;
  List<TournamentBase> _tournaments = [];
  TournamentSortOptionEnum _sortOption = TournamentSortOptionEnum.dateNewest;
  bool _isLoading = false;

  TournamentListProvider(this._storage, this._prefs) {
    _init();
  }

  List<TournamentBase> get tournaments => _tournaments;
  TournamentSortOptionEnum get sortOption => _sortOption;
  bool get isLoading => _isLoading;

  void _init() {
    final saved = _prefs.getSortOption();
    if (saved != null) {
      _sortOption = TournamentSortOptionEnum.values.firstWhere(
        (e) => e.name == saved,
        orElse: () => TournamentSortOptionEnum.dateNewest,
      );
    }
  }

  Future<void> loadTournaments() async {
    _isLoading = true;
    notifyListeners();
    _tournaments = await _storage.getAll();
    _applySort();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteTournament(String id) async {
    await _storage.delete(id);
    _tournaments.removeWhere((t) => t.id == id);
    notifyListeners();
  }

  void setSortOption(TournamentSortOptionEnum option) {
    _sortOption = option;
    _prefs.saveSortOption(option.name);
    _applySort();
    notifyListeners();
  }

  void _applySort() {
    switch (_sortOption) {
      case TournamentSortOptionEnum.nameAsc:
        _tournaments.sort((a, b) => _compareNaturalSpanish(a.name, b.name));
      case TournamentSortOptionEnum.nameDesc:
        _tournaments.sort((a, b) => _compareNaturalSpanish(b.name, a.name));
      case TournamentSortOptionEnum.dateNewest:
        _tournaments.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      case TournamentSortOptionEnum.dateOldest:
        _tournaments.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    }
  }

  int _compareNaturalSpanish(String a, String b) {
    String prepare(String text) {
      return text
          .toLowerCase()
          .replaceAll('á', 'a')
          .replaceAll('é', 'e')
          .replaceAll('í', 'i')
          .replaceAll('ó', 'o')
          .replaceAll('ú', 'u')
          .replaceAll('ñ', 'nzz');
    }

    return compareNatural(prepare(a), prepare(b));
  }
}
