import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class AuthErrorDisplay extends StatelessWidget {
  final String? errorMessage;
  final bool isDark;

  const AuthErrorDisplay({
    this.errorMessage,
    this.isDark = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (errorMessage == null) return const SizedBox.shrink();

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.error
                : AppColors.error.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.error),
          ),
          child: Text(
            errorMessage!,
            style: TextStyle(
              color: isDark ? Colors.white : AppColors.error,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
