// screens/tournament.dart
import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/widgets/app_bar.dart';
import 'package:cuarta_ruta_app/core/providers/theme_provider.dart';
import 'package:cuarta_ruta_app/core/utils/responsive.dart';
import 'package:provider/provider.dart';

class Tournament extends StatelessWidget {
  const Tournament({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final responsive = Responsive.of(context);

    return Scaffold(
      appBar: MyAppBar(
        isDarkMode: themeProvider.isDarkMode,
        onToggleDarkMode: themeProvider.toggleTheme,
        responsive: responsive,
      ),
      body: const Center(
        child: Text('Pantalla de Torneo'),
      ),
    );
  }
}