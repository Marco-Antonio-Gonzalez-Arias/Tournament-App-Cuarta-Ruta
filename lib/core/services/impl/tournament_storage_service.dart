import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cuarta_ruta_app/core/enums/tournament_type_enum.dart';
import 'package:cuarta_ruta_app/core/services/tournament_storage_base.dart';
import 'package:cuarta_ruta_app/models/tournament_base.dart';
import 'package:cuarta_ruta_app/models/impl/knockout_tournament_model.dart';
import 'package:cuarta_ruta_app/models/impl/league_tournament_model.dart';

class TournamentStorageService implements TournamentStorageBase {
  final SharedPreferences _prefs;
  static const String _storageKey = 'tournaments';

  TournamentStorageService(this._prefs);

  @override
  Future<void> create(TournamentBase tournament) async {
    final tournaments = await getAll();
    tournaments.add(tournament);
    await _save(tournaments);
  }

  @override
  Future<void> update(TournamentBase tournament) async {
    final tournaments = await getAll();
    final index = tournaments.indexWhere((t) => t.id == tournament.id);
    if (index != -1) {
      tournaments[index] = tournament;
      await _save(tournaments);
    }
  }

  @override
  Future<List<TournamentBase>> getAll() async {
    final source = _prefs.getString(_storageKey);
    return source == null ? [] : _decode(source);
  }

  @override
  Future<void> delete(String id) async {
    final tournaments = await getAll();
    tournaments.removeWhere((t) => t.id == id);
    await _save(tournaments);
  }

  Future<void> _save(List<TournamentBase> tournaments) async {
    final data = tournaments.map((t) => (t as dynamic).toJson()).toList();
    await _prefs.setString(_storageKey, jsonEncode(data));
  }

  List<TournamentBase> _decode(String source) {
    final List decoded = jsonDecode(source);
    return decoded.map((item) {
      final map = item as Map<String, dynamic>;
      final type = TournamentTypeEnum.values.byName(map['type']);

      return type == TournamentTypeEnum.knockout
          ? KnockoutTournamentModel.fromJson(map)
          : LeagueTournamentModel.fromJson(map);
    }).toList();
  }
}
