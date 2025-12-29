import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cuarta_ruta_app/models/tournament_model.dart';

class TournamentStorageService {
  static const String _tournamentsKey = 'tournaments';

  // Guardar torneo
  Future<void> saveTournament(TournamentModel tournament) async {
    final prefs = await SharedPreferences.getInstance();
    final tournaments = await getAllTournaments();
    
    // Busca si ya existe y actualiza, si no, agrega
    final index = tournaments.indexWhere((t) => t.id == tournament.id);
    if (index != -1) {
      tournaments[index] = tournament;
    } else {
      tournaments.add(tournament);
    }
    
    final jsonList = tournaments.map((t) => t.toJson()).toList();
    await prefs.setString(_tournamentsKey, jsonEncode(jsonList));
  }

  // Obtener todos los torneos
  Future<List<TournamentModel>> getAllTournaments() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_tournamentsKey);
    
    if (jsonString == null) return [];
    
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => TournamentModel.fromJson(json)).toList();
  }

  // Obtener torneo por ID
  Future<TournamentModel?> getTournamentById(String id) async {
    final tournaments = await getAllTournaments();
    try {
      return tournaments.firstWhere((t) => t.id == id);
    } catch (e) {
      return null;
    }
  }

  // Eliminar torneo
  Future<void> deleteTournament(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final tournaments = await getAllTournaments();
    tournaments.removeWhere((t) => t.id == id);
    
    final jsonList = tournaments.map((t) => t.toJson()).toList();
    await prefs.setString(_tournamentsKey, jsonEncode(jsonList));
  }
}