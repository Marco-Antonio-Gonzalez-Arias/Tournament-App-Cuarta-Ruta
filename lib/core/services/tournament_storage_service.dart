import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cuarta_ruta_app/models/tournament_model.dart';

class TournamentStorageService {
  final SharedPreferences _prefs;
  static const String _storageKey = 'tournaments';

  TournamentStorageService(this._prefs);

  Future<void> create(TournamentModel tournament) async {
    final tournaments = await getAll();
    tournaments.add(tournament);
    await _save(tournaments);
  }

  Future<void> update(TournamentModel tournament) async {
    final tournaments = await getAll();
    final index = tournaments.indexWhere((t) => t.id == tournament.id);
    if (index != -1) {
      tournaments[index] = tournament;
      await _save(tournaments);
    }
  }

  Future<List<TournamentModel>> getAll() async {
    final source = _prefs.getString(_storageKey);
    return source == null ? [] : _decode(source);
  }

  Future<void> delete(String id) async {
    final tournaments = await getAll();
    tournaments.removeWhere((t) => t.id == id);
    await _save(tournaments);
  }

  Future<void> _save(List<TournamentModel> tournaments) async {
    final data = tournaments.map((t) => t.toJson()).toList();
    await _prefs.setString(_storageKey, jsonEncode(data));
  }

  List<TournamentModel> _decode(String source) {
    final List decoded = jsonDecode(source);
    return decoded.map((item) => TournamentModel.fromJson(item)).toList();
  }
}
