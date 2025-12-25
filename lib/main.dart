import 'package:cuarta_ruta_app/config/app_theme.dart';
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
  bool _isDarkMode = false;

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme(colorSeed: Colors.deepPurple, isDarkMode: _isDarkMode).theme(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Cuarta Ruta"),
          actions: [
            IconButton(
              icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: _toggleDarkMode,
            ),
          ],
          ),
        body: Center(
          child: FilledButton.icon(
            onPressed: () {},
            label: const Text("Prueba de tema"),
            icon: const Icon(Icons.check),
          ),
        ),
      ),
    );
  }
}
