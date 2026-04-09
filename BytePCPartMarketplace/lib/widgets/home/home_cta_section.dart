import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';

class HomeCtaSection extends StatelessWidget {
  final bool isLoggedIn;

  const HomeCtaSection({required this.isLoggedIn, super.key});

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
      color: AppColors.background,
      child: Column(
        children: [
          const Text(
            'Ready to get started?',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'Create a free account and start buying or selling today.',
            style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              Tooltip(
                message: 'Join BYTE and start buying or selling today',
                child: ElevatedButton(
                  onPressed: () => context.go(AppRoutes.register),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                  ),
                  child: const Text('Create Free Account',
                      style: TextStyle(fontSize: 16)),
                ),
              ),
              Tooltip(
                message: 'Sign in with existing account',
                child: OutlinedButton(
                  onPressed: () => context.go(AppRoutes.login),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                  ),
                  child: const Text('Login', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
