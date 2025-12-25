import 'package:cuarta_ruta_app/config/app_theme.dart';
import 'package:cuarta_ruta_app/utils/responsive.dart';
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
  bool _isDarkMode = false;

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme(
        colorSeed: Colors.yellow,
        isDarkMode: _isDarkMode,
      ).theme(),
      home: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.all(responsive.dp(0.7)),
            child: Image.asset(
              _isDarkMode 
                ? 'assets/icon/icon_light.png' 
                : 'assets/icon/icon_black.png'
            ),
          ),
          title: Text(
            "CUARTA RUTA",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: responsive.dp(2.5)
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
              iconSize: responsive.dp(3),
              onPressed: _toggleDarkMode,
            ),
          ],
        ),
        body: const Home(),
      ),
    );
  }
}