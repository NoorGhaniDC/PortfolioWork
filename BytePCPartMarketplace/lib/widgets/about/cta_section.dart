import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';

class CTASection extends StatelessWidget {
  const CTASection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
      color: AppColors.navbarBg,
      child: Column(
        children: [
          const Text(
            'Start Building Your PC Today',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'Browse listings, sell with precision, and buy with confidence.',
            style: TextStyle(fontSize: 16, color: Colors.white70),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              Tooltip(
                message: 'Browse available PC components in the marketplace',
                child: ElevatedButton(
                  onPressed: () => context.go(AppRoutes.marketplace),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.navbarBg,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                  ),
                  child: const Text('Browse Marketplace',
                      style: TextStyle(fontSize: 16)),
                ),
              ),
              Tooltip(
                message: 'Create a new account to start buying or selling',
                child: OutlinedButton(
                  onPressed: () => context.go(AppRoutes.register),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                  ),
                  child: const Text('Create Account',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ],
          ),
          // Developer button (only shown in debug mode)
          if (kDebugMode) ...[
            const SizedBox(height: 48),
            const Divider(color: Colors.white24, thickness: 1),
            const SizedBox(height: 24),
            Tooltip(
              message:
                  'Populate database with sample listings (development only)',
              child: TextButton.icon(
                onPressed: () => context.go(AppRoutes.seedHelper),
                icon: const Icon(Icons.developer_mode, color: Colors.white70),
                label: const Text(
                  '🛠️ Developer: Seed Database',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
