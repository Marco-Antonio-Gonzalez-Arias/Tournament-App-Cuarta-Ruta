import 'package:cuarta_ruta_app/models/tournament_model.dart';

abstract class TournamentStorageBase {
  Future<void> create(TournamentModel tournament);
  Future<void> update(TournamentModel tournament);
  Future<List<TournamentModel>> getAll();
  Future<void> delete(String id);
}
