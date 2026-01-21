import 'package:cuarta_ruta_app/models/tournament_progress_base.dart';

abstract class TournamentProgressStorageBase {
  Future<void> save(TournamentProgressBase progress);
  Future<TournamentProgressBase?> getByTournamentId(String tournamentId);
  Future<List<TournamentProgressBase>> getAll();
  Future<void> delete(String id);
}
