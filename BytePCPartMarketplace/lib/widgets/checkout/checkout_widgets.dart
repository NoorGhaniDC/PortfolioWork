import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class SectionHeading extends StatelessWidget {
  final String text;

  const SectionHeading(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  }
}

class PlaceholderThumb extends StatelessWidget {
  const PlaceholderThumb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      color: AppColors.primary.withValues(alpha: 0.08),
      child: const Icon(Icons.computer, color: AppColors.primary, size: 24),
    );
  }
}
