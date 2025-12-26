import 'package:cuarta_ruta_app/core/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/config/app_theme.dart';
import 'package:cuarta_ruta_app/screens/home.dart';
import 'package:cuarta_ruta_app/core/widgets/app_bar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme(
        colorSeed: Colors.yellow,
        isDarkMode: themeProvider.isDarkMode,
      ).theme(),
      home: Scaffold(
        appBar: MyAppBar(
          isDarkMode: themeProvider.isDarkMode,
          onToggleDarkMode: themeProvider.toggleTheme,
        ),
        body: const Home(),
      ),
    );
  }
}