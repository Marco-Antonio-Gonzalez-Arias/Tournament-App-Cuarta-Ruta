import 'package:cuarta_ruta_app/core/utils/responsive.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return Center(
      child: Text(
        'Hola Mundo',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontFamily: 'Bangers',
          fontSize: responsive.dp(4),
        ),
      ),
    );
  }
}
