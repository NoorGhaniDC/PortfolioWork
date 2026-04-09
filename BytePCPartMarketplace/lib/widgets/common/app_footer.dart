import 'package:bytepcmarketplace/core/constants/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24),
      color: AppColors.secondary,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '© 2025 BYTE - The PC Part Marketplace · Built with Flutter & Firebase',
            style: TextStyle(color: Colors.white54, fontSize: 13),
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: () => context.go(AppRoutes.about),
            child: const Text(
              'About',
              style: TextStyle(color: Colors.white54, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
