import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cuarta_ruta_app/models/tournament_model.dart';

class TournamentStorageService {
  static const String _key = 'tournaments';

  Future<void> create(TournamentModel tournament) async {
    final list = await getAll();
    list.add(tournament);
    await _save(list);
  }

  Future<void> update(TournamentModel tournament) async {
    final list = await getAll();
    final index = list.indexWhere((t) => t.id == tournament.id);
    if (index != -1) {
      list[index] = tournament;
      await _save(list);
    }
  }

  Future<List<TournamentModel>> getAll() async {
    final prefs = await SharedPreferences.getInstance();
    final source = prefs.getString(_key);
    return source == null ? [] : _decode(source);
  }

  Future<void> delete(String id) async {
    final list = await getAll();
    list.removeWhere((t) => t.id == id);
    await _save(list);
  }

  Future<void> _save(List<TournamentModel> list) async {
    final prefs = await SharedPreferences.getInstance();
    final data = list.map((t) => t.toJson()).toList();
    await prefs.setString(_key, jsonEncode(data));
  }

  List<TournamentModel> _decode(String source) {
    final List decoded = jsonDecode(source);
    return decoded.map((item) => TournamentModel.fromJson(item)).toList();
  }
}