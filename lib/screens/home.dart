import 'package:cuarta_ruta_app/core/config/theme/app_colors.dart';
import 'package:cuarta_ruta_app/core/widgets/logo_image.dart';
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
          padding: EdgeInsets.symmetric(horizontal: responsive.wp(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLogo(responsive),
              const SizedBox(height: 50),
              _buildMenuButton(context, 'Torneo'),
              const SizedBox(height: 20),
              _buildMenuButton(context, 'Libre'),
              const SizedBox(height: 20),
              _buildMenuButton(context, 'Visuales'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(Responsive responsive) {
    return LogoImage(height: responsive.hp(20));
  }

  Widget _buildMenuButton(BuildContext context, String label) {
    return SizedBox(
      width: double.infinity,
      height: 80,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.primaryGold, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
