import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/config/app_theme.dart';
import 'package:cuarta_ruta_app/screens/home.dart';
import 'package:cuarta_ruta_app/shared_widgets/app_bar.dart';

void main() => runApp(const MainApp());

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool _isDarkMode = false;
  void _toggleDarkMode() => setState(() => _isDarkMode = !_isDarkMode);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _buildCurrentTheme(),
      home: _buildMainScreen(),
    );
  }

  ThemeData _buildCurrentTheme() {
    return AppTheme(
      colorSeed: Colors.yellow,
      isDarkMode: _isDarkMode,
    ).theme();
  }

  Widget _buildMainScreen() {
    return Scaffold(
      appBar: MyAppBar(
        isDarkMode: _isDarkMode,
        onToggleDarkMode: _toggleDarkMode,
      ),
      body: const Home(),
    );
  }
}