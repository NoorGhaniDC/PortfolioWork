import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class FeatureCard extends StatelessWidget {
  final Map<String, dynamic> feature;

  const FeatureCard({required this.feature, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(feature['icon'] as IconData,
                size: 48, color: AppColors.primary),
            const SizedBox(height: 16),
            Text(
              feature['title'] as String,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              feature['desc'] as String,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
