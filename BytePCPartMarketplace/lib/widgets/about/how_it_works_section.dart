import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'step_card.dart';

class HowItWorksSection extends StatelessWidget {
  final bool isWide;

  const HowItWorksSection({required this.isWide, super.key});

  @override
  Widget build(BuildContext context) {
    final steps = [
      {
        'step': '1',
        'title': 'Create an Account',
        'desc':
            'Register for free to unlock the ability to buy and sell components on the platform.',
        'icon': Icons.person_add_outlined,
      },
      {
        'step': '2',
        'title': 'Browse or List',
        'desc':
            'Search thousands of listings by category, price, and condition — or create your own listing in minutes.',
        'icon': Icons.search,
      },
      {
        'step': '3',
        'title': 'Buy or Sell',
        'desc':
            'Connect with buyers and sellers directly through structured, transparent listings.',
        'icon': Icons.handshake_outlined,
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 80 : 24,
        vertical: 64,
      ),
      color: AppColors.surface,
      child: Column(
        children: [
          const Text(
            'How It Works',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: steps
                      .map((s) => Expanded(child: StepCard(step: s)))
                      .toList(),
                )
              : Column(
                  children: steps.map((s) => StepCard(step: s)).toList(),
                ),
        ],
      ),
    );
  }
}
