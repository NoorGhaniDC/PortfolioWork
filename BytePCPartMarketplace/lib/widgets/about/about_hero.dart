import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';

class AboutHero extends StatelessWidget {
  final bool isWide;

  const AboutHero({required this.isWide, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 80 : 24,
        vertical: isWide ? 64 : 40,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.navbarBg, AppColors.primary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          const Icon(Icons.info_outline, size: 56, color: Colors.white70),
          const SizedBox(height: 16),
          Text(
            'About ${AppStrings.appName}',
            style: TextStyle(
              fontSize: isWide ? 40 : 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          const Text(
            'A dedicated marketplace built specifically for PC hardware enthusiasts',
            style: TextStyle(fontSize: 16, color: Colors.white70),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
