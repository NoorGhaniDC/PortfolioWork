import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';
import '../../core/constants/app_strings.dart';

class HeroSection extends StatelessWidget {
  final bool isLoggedIn;
  final bool isWide;

  const HeroSection({
    required this.isLoggedIn,
    required this.isWide,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 80 : 24,
        vertical: isWide ? 80 : 48,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.navbarBg, AppColors.primary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.computer, size: 64, color: Colors.white70),
          const SizedBox(height: 24),
          Text(
            AppStrings.appName,
            style: TextStyle(
              fontSize: isWide ? 48 : 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            AppStrings.appTagline,
            style: TextStyle(
              fontSize: isWide ? 20 : 16,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              Tooltip(
                message: 'Start browsing PC components',
                child: ElevatedButton.icon(
                  onPressed: () => context.go(AppRoutes.marketplace),
                  icon: const Icon(Icons.storefront),
                  label: const Text('Browse Marketplace',
                      style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.navbarBg,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 16),
                  ),
                ),
              ),
              if (!isLoggedIn)
                Tooltip(
                  message: 'Create an account to start selling',
                  child: OutlinedButton.icon(
                    onPressed: () => context.go(AppRoutes.register),
                    icon: const Icon(Icons.person_add, color: Colors.white),
                    label: const Text('Get Started',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 16),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
