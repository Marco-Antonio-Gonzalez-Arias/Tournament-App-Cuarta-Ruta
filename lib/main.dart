import 'package:cuarta_ruta_app/config/app_theme.dart';
import 'package:cuarta_ruta_app/controllers/theme_controller.dart';
import 'package:cuarta_ruta_app/controllers/app_bar_controller.dart';
import 'package:cuarta_ruta_app/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final ThemeController _themeController = ThemeController();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _themeController,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme(
            colorSeed: Colors.yellow,
            isDarkMode: _themeController.isDarkMode,
          ).theme(),
          home: Scaffold(
            appBar: CustomAppBar(
              isDarkMode: _themeController.isDarkMode,
              onToggleDarkMode: _themeController.toggleDarkMode,
            ),
            body: const Home(),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _themeController.dispose();
    super.dispose();
  }
}