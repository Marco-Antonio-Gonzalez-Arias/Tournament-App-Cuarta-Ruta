import 'package:shared_preferences/shared_preferences.dart';
import 'package:cuarta_ruta_app/core/services/app_preferences_base.dart';

class AppPreferencesService implements AppPreferencesBase {
  final SharedPreferences _prefs;

  static const String _sortKey = 'tournament_sort_option';

  AppPreferencesService(this._prefs);

  @override
  Future<void> saveSortOption(String option) async =>
      await _prefs.setString(_sortKey, option);

  @override
  String? getSortOption() => _prefs.getString(_sortKey);
}
