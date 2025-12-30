import 'package:cuarta_ruta_app/core/providers/theme_provider.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';
import 'package:cuarta_ruta_app/core/widgets/border_decorator_widget.dart';
import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/config/theme/app_theme_config.dart';
import 'package:cuarta_ruta_app/screens/home_screen.dart';
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
    final responsive = ResponsiveUtil.of(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemeConfig(
        isDarkMode: themeProvider.isDarkMode(context),
        responsive: responsive,
      ).theme(),
      builder: (context, child) => BorderDecoratorWidget(child: child!),
      title: 'Cuarta Ruta App',
      home: const HomeScreen(),
    );
  }
}
