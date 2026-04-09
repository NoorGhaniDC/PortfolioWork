import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class CartPlaceholderThumb extends StatelessWidget {
  const CartPlaceholderThumb({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      color: AppColors.primary.withValues(alpha: 0.08),
      child: const Icon(Icons.computer, color: AppColors.primary, size: 32),
    );
  }
}
