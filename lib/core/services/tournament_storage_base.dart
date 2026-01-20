import 'package:cuarta_ruta_app/models/tournament_base.dart';

abstract class TournamentStorageBase {
  Future<void> create(TournamentBase tournament);
  Future<void> update(TournamentBase tournament);
  Future<List<TournamentBase>> getAll();
  Future<void> delete(String id);
}
