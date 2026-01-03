import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cuarta_ruta_app/core/config/theme/app_theme_config.dart';
import 'package:cuarta_ruta_app/core/providers/theme_provider.dart';
import 'package:cuarta_ruta_app/core/services/tournament_storage_base.dart';
import 'package:cuarta_ruta_app/core/services/tournament_storage_service.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';
import 'package:cuarta_ruta_app/core/widgets/border_decorator_widget.dart';
import 'package:cuarta_ruta_app/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MultiProvider(
      providers: [
        Provider<TournamentStorageBase>(
          create: (_) => TournamentStorageService(sharedPreferences),
        ),
        ChangeNotifierProvider(create: (_) => ThemeProvider(sharedPreferences)),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cuarta Ruta App',
      theme: _buildTheme(context),
      builder: _applyGlobalDecorator,
      home: const HomeScreen(),
    );
  }

  ThemeData _buildTheme(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return AppThemeConfig(
      isDarkMode: themeProvider.isDarkMode(context),
      responsive: context.res,
    ).theme();
  }

  Widget _applyGlobalDecorator(BuildContext context, Widget? child) {
    return BorderDecoratorWidget(child: child!);
  }
}
