import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class GuideSection extends StatelessWidget {
  final String title;
  final List<String> points;

  const GuideSection({
    required this.title,
    required this.points,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        ...points.map((point) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                '• $point',
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
            )),
      ],
    );
  }
}
