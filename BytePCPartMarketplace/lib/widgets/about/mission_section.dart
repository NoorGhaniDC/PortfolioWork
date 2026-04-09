import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class MissionSection extends StatelessWidget {
  final bool isWide;

  const MissionSection({required this.isWide, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 120 : 24,
        vertical: 64,
      ),
      color: AppColors.background,
      child: const Column(
        children: [
          Text(
            'Our Mission',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          Text(
            'BYTE was created to solve a real problem in the second-hand hardware market — '
            'buyers struggle to find trustworthy listings with accurate specifications, and sellers '
            'have no dedicated platform to reach the right audience.',
            style: TextStyle(
                fontSize: 16, color: AppColors.textSecondary, height: 1.6),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Text(
            'Our goal is to reduce cost, improve trust, and simplify the buying and selling '
            'process for PC components through structured listings and verified specs.',
            style: TextStyle(
                fontSize: 16, color: AppColors.textSecondary, height: 1.6),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
