import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'feature_card.dart';

class FeaturesSection extends StatelessWidget {
  final bool isWide;

  const FeaturesSection({required this.isWide, super.key});

  @override
  Widget build(BuildContext context) {
    final features = [
      {
        'icon': Icons.verified_outlined,
        'title': 'Trusted Listings',
        'desc':
            'Structured listings with verified specs so you always know what you\'re buying.',
      },
      {
        'icon': Icons.search,
        'title': 'Smart Filtering',
        'desc':
            'Filter by category, price, and condition to find exactly what you need.',
      },
      {
        'icon': Icons.sell_outlined,
        'title': 'Easy Selling',
        'desc':
            'List your components in minutes with guided forms and spec templates.',
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 80 : 24,
        vertical: 64,
      ),
      color: AppColors.background,
      child: Column(
        children: [
          const Text(
            'Why Choose Byte?',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'Everything you need to buy and sell PC components with confidence',
            style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: features
                      .map((f) => Expanded(child: FeatureCard(feature: f)))
                      .toList(),
                )
              : Column(
                  children:
                      features.map((f) => FeatureCard(feature: f)).toList(),
                ),
        ],
      ),
    );
  }
}
