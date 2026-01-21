import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cuarta_ruta_app/core/enums/tournament_type_enum.dart';
import 'package:cuarta_ruta_app/core/services/tournament_progress_storage_base.dart';
import 'package:cuarta_ruta_app/models/tournament_progress_base.dart';
import 'package:cuarta_ruta_app/models/impl/knockout_progress_model.dart';
import 'package:cuarta_ruta_app/models/impl/league_progress_model.dart';

class TournamentProgressStorageService
    implements TournamentProgressStorageBase {
  final SharedPreferences _prefs;
  static const String _storageKey = 'tournaments_progress';

  TournamentProgressStorageService(this._prefs);

  @override
  Future<void> save(TournamentProgressBase progress) async {
    final allProgress = await getAll();
    final index = allProgress.indexWhere((p) => p.id == progress.id);

    if (index != -1) {
      allProgress[index] = progress;
    } else {
      allProgress.add(progress);
    }
    await _saveAll(allProgress);
  }

  @override
  Future<TournamentProgressBase?> getByTournamentId(String tournamentId) async {
    final allProgress = await getAll();
    try {
      return allProgress.firstWhere((p) => p.tournamentId == tournamentId);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<TournamentProgressBase>> getAll() async {
    final source = _prefs.getString(_storageKey);
    return source == null ? [] : _decode(source);
  }

  @override
  Future<void> delete(String id) async {
    final allProgress = await getAll();
    allProgress.removeWhere((p) => p.id == id);
    await _saveAll(allProgress);
  }

  Future<void> _saveAll(List<TournamentProgressBase> allProgress) async {
    final data = allProgress.map((p) => (p as dynamic).toJson()).toList();
    await _prefs.setString(_storageKey, jsonEncode(data));
  }

  List<TournamentProgressBase> _decode(String source) {
    final List decoded = jsonDecode(source);
    return decoded.map((item) {
      final map = item as Map<String, dynamic>;
      final type = TournamentTypeEnum.values.byName(map['type']);

      return type == TournamentTypeEnum.knockout
          ? KnockoutProgressModel.fromJson(map)
          : LeagueProgressModel.fromJson(map);
    }).toList();
  }
}
