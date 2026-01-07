import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/config/routes/app_routes.dart';
import 'package:cuarta_ruta_app/screens/home_screen.dart';
import 'package:cuarta_ruta_app/screens/tournament/tournament_menu_screen.dart';
import 'package:cuarta_ruta_app/screens/tournament/list/tournament_list_screen.dart';
import 'package:cuarta_ruta_app/screens/tournament/creation/tournament_creation_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const HomeScreen(),
        );
      case AppRoutes.tournamentMenu:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const TournamentMenuScreen(),
        );
      case AppRoutes.tournamentList:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const TournamentListScreen(),
        );
      case AppRoutes.tournamentCreation:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const TournamentCreationScreen(),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) =>
          const Scaffold(body: Center(child: Text('Pantalla no encontrada'))),
    );
  }
}
