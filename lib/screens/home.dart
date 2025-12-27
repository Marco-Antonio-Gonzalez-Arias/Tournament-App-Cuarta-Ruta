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
          padding: EdgeInsets.symmetric(horizontal: responsive.wp(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLogo(responsive),
              SizedBox(height: responsive.hp(10)),
              _buildMenuButton(context, responsive, 'Torneo'),
              SizedBox(height: responsive.hp(10)),
              _buildMenuButton(context, responsive, 'Libre'),
              SizedBox(height: responsive.hp(10)),
              _buildMenuButton(context, responsive, 'Visuales'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(Responsive responsive) {
    return LogoImage(height: responsive.hp(15));
  }

  Widget _buildMenuButton(BuildContext context, Responsive responsive, String label) {
    return SizedBox(
      width: double.infinity,
      height: 80,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: AppColors.primaryGold, width: responsive.dp(0.3)),
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
