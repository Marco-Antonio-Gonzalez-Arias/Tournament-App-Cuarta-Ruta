import 'package:cuarta_ruta_app/core/widgets/button.dart';
import 'package:cuarta_ruta_app/core/widgets/logo_image.dart';
import 'package:cuarta_ruta_app/screens/tournament.dart';
import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/utils/responsive.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: responsive.wp(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLogo(responsive),
              SizedBox(height: responsive.hp(10)),
              Button(
                label: 'Torneo',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Tournament()),
                  );
                },
              ),
              SizedBox(height: responsive.hp(3)),
              Button(label: 'Libre', onPressed: () {}),
              SizedBox(height: responsive.hp(3)),
              Button(label: 'Visuales', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(Responsive responsive) {
    return LogoImage(height: responsive.hp(15));
  }
}
