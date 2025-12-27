import 'package:cuarta_ruta_app/core/providers/theme_provider.dart';
import 'package:cuarta_ruta_app/core/utils/responsive.dart';
import 'package:cuarta_ruta_app/core/widgets/border_decorator.dart';
import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/config/theme/app_theme.dart';
import 'package:cuarta_ruta_app/screens/home.dart';
import 'package:cuarta_ruta_app/core/widgets/app_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

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
    final responsive = Responsive.of(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme(
        isDarkMode: themeProvider.isDarkMode,
        responsive: responsive,
      ).theme(),
      builder: (context, child) => BorderDecorator(child: child!),
      home: Scaffold(
        appBar: MyAppBar(
          isDarkMode: themeProvider.isDarkMode,
          onToggleDarkMode: themeProvider.toggleTheme,
          responsive: responsive,
        ),
        body: const Home(),
      ),
    );
  }
}
